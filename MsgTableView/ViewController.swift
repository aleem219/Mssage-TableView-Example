//
//  ViewController.swift
//  MsgTableView
//
//  Created by Abdul Aleem on 19/11/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        observeAppActiveState()
    }
}

extension ViewController {
    
    func refreshTable() {
        self.tableView.reloadData()
    }
    
    func observeAppActiveState() {
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { _ in
                print("App became active")
                self.refreshTable()
            }
            .store(in: &cancellables)
    }
    
    func registerTableCell() {
        tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UINib(nibName: "MsgCell", bundle: nil), forCellReuseIdentifier: "MsgCell")
        self.tableView.register(UINib(nibName: "RightCell", bundle: nil), forCellReuseIdentifier: "RightCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MsgCell", for: indexPath) as! MsgCell
            cell.selectionStyle = .none
            cell.imgPerson.layer.cornerRadius = cell.imgPerson.frame.height / 2
            cell.imgPerson.layer.borderWidth = 1
            cell.imgPerson.layer.borderColor = UIColor.systemPink.cgColor
            cell.lblMsg.text = "Left Side Abdul Aleem Usmani"
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightCell", for: indexPath) as! RightCell
            cell.configure(text: "Right Side Ayaaz Ahmad Usmani")
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
  
}

