//
//  ViewController.swift
//  MsgTableView
//
//  Created by Abdul Aleem on 19/11/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var bottomViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var msgTextView: UITextView!
    
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        tableView.rowHeight = UITableView.automaticDimension
        observeAppActiveState()
        setMsgTextView()
    }
    
    
    @IBAction func btnSendAction(_ sender: UIButton) {
        let isPlaceholder = msgTextView.textColor == UIColor.lightGray
        let isEmpty = msgTextView.text.trimmingCharacters(in: .whitespaces).isEmpty
        print(isPlaceholder || isEmpty ? "Please enter your msg" : "msg has been sent")
       handleMsgTextViewAfterSend()
    }
}

extension ViewController {
    
    func registerTableCell() {
        tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UINib(nibName: "MsgCell", bundle: nil), forCellReuseIdentifier: "MsgCell")
        self.tableView.register(UINib(nibName: "RightCell", bundle: nil), forCellReuseIdentifier: "RightCell")
    }
    
    func observeAppActiveState() {
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { _ in
                print("App became active")
                self.refreshTable()
            }
            .store(in: &cancellables)
    }
    
    func refreshTable() {
        bottomView.layer.cornerRadius = bottomView.frame.height / 2
        btnSend.layer.cornerRadius = btnSend.frame.height / 2
        btnSend.layer.borderWidth = 1
        btnSend.layer.borderColor = UIColor(named: "#008000")?.withAlphaComponent(0.1).cgColor
        self.tableView.reloadData()
    }
    
    func setMsgTextView() {
        msgTextView.isScrollEnabled = false
        msgTextView.delegate = self
        msgTextView.text = "Message"
        msgTextView.textColor = UIColor.lightGray
        
        DispatchQueue.main.async {
            self.centerTextVertically(self.msgTextView)
        }
    }
    
    func handleMsgTextViewAfterSend() {
        msgTextView.text = "Message"
        msgTextView.textColor = UIColor.lightGray
        msgTextView.isScrollEnabled = false
        bottomViewHeightConst.constant = 45
        msgTextView.resignFirstResponder()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
        DispatchQueue.main.async {
            self.centerTextVertically(self.msgTextView)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MsgCell", for: indexPath) as! MsgCell
            cell.selectionStyle = .none
            cell.lblMsg.text = "Left Side Abdul Aleem Usmani "
            cell.configure(text: "Left Side Abdul Aleem Usmani Left Side Abdul Aleem Usmani ")
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightCell", for: indexPath) as! RightCell
            cell.selectionStyle = .none
            cell.configure(text: "Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani Right Side Ayaaz Ahmad Usmani ")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.contentInset = .zero
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespaces).isEmpty {
            textView.text = "Placeholder text goes right here..."
            textView.textColor = UIColor.lightGray
            centerTextVertically(textView)
        }
    }
    
    func centerTextVertically(_ textView: UITextView) {
        let fittingSize = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let topOffset = max(0, (textView.bounds.height - fittingSize.height) / 2)
        textView.contentInset = UIEdgeInsets(top: topOffset, left: 0, bottom: 0, right: 0)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fittingSize = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        let minHeight: CGFloat = 45
        let maxHeight: CGFloat = 200
        
        let newHeight = min(max(fittingSize.height + 20, minHeight), maxHeight)
        
        bottomViewHeightConst.constant = newHeight
        textView.isScrollEnabled = newHeight >= maxHeight
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
