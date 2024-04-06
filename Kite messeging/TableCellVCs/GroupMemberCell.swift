//
//  GroupMemberCell.swift
//  Kite messeging
//
//  Created by Admin on 26/03/24.
//

import UIKit

class GroupMemberCell: UITableViewCell {
    
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var activeStatus: UILabel!
    
    var removeButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Add target action for the remove button
              removeBtn.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    @objc func removeButtonTapped() {
           removeButtonAction?()
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with image: UIImage?) {
            memberImage.image = image
        }
}
