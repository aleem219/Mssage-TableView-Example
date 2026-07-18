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
 
    private var didFixConstraints = false
    private var maxWidthConstraint: NSLayoutConstraint?
 
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        fixConstraintsIfNeeded()
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.layer.sublayers?.filter { $0.name == "bubbleLayer" }.forEach { $0.removeFromSuperlayer() }
        mainView.layer.mask = nil
    }
 
    override func layoutSubviews() {
        maxWidthConstraint?.constant = UIScreen.main.bounds.width * 0.75
        super.layoutSubviews()
        mainView.applyRightBubble()
    }
    private func fixConstraintsIfNeeded() {
        guard !didFixConstraints else { return }
        didFixConstraints = true
 
        let toRemove = contentView.constraints.filter {
            ($0.firstItem as? UIView) == mainView || ($0.secondItem as? UIView) == mainView
        }
        NSLayoutConstraint.deactivate(toRemove)
 
        let toRemoveSelf = self.constraints.filter {
            ($0.firstItem as? UIView) == mainView || ($0.secondItem as? UIView) == mainView
        }
        NSLayoutConstraint.deactivate(toRemoveSelf)
 
        mainView.translatesAutoresizingMaskIntoConstraints = false
 
        let trailing = mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        let top = mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4)
        let bottom = mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        let leadingFloat = mainView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 60)
 
        let maxWidth = mainView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.75)
        maxWidthConstraint = maxWidth
        NSLayoutConstraint.activate([trailing, top, bottom, leadingFloat, maxWidth])
        mainView.setContentHuggingPriority(.required, for: .horizontal)
        lblMsg.setContentCompressionResistancePriority(.required, for: .horizontal)
        lblMsg.numberOfLines = 0
    }
 
    func configure(text: String) {
        lblMsg.text = text
        lblMsg.numberOfLines = 0
        mainView.backgroundColor = .secondarySystemGroupedBackground
        mainView.clipsToBounds = false
        mainView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        self.clipsToBounds = false
    }
}
