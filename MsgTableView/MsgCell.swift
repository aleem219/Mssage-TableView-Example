//
//  MsgCell.swift
//  MsgTableView
//
//  Created by Abdul Aleem on 19/11/25.
//

import UIKit

class MsgCell: UITableViewCell {
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgPerson: UIImageView!
    
    override func prepareForReuse() {
          super.prepareForReuse()
          mainView.layer.sublayers?.filter { $0.name == "bubbleLayer" }.forEach { $0.removeFromSuperlayer() }
          mainView.layer.mask = nil
      }

      override func layoutSubviews() {
          super.layoutSubviews()
          mainView.applyLeftBubble()
      }
    
    
    func configure(text: String) {
        lblMsg.text = text
        mainView.backgroundColor = .secondarySystemGroupedBackground
        
        mainView.clipsToBounds = false
        mainView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        self.clipsToBounds = false
        
        imgPerson.layer.cornerRadius = imgPerson.frame.height / 2
        imgPerson.layer.borderWidth = 1
        imgPerson.layer.borderColor = UIColor.systemPink.cgColor
    }

    
}
