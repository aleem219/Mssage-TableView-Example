//
//  RightCell.swift
//  MsgTableView
//
//  Created by Abdul Aleem on 19/11/25.
//

import UIKit

class RightCell: UITableViewCell {

    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var mainView: UIView!

    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.layer.mask = nil
    }

    func configure(text: String) {
        lblMsg.text = text

        DispatchQueue.main.async {
            self.mainView.applyRightBubble()
        }
    }
}
