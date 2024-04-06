//
//  ContactTableCell.swift
//  Kite messeging
//
//  Created by Admin on 22/03/24.
//

import UIKit

protocol ContactTableViewCellDelegate: AnyObject {
    func didSelectContact(_ cell: ContactTableCell)
}
class ContactTableCell: UITableViewCell {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactStatus: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    weak var delegate: ContactTableViewCellDelegate?
    var isSelectedContact: Bool = false {
        didSet {
            let imageName = isSelectedContact ? "checkbox_checked" : "checkbox_unchecked"
            checkBox.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    func configure(with contact: Contact) {
        contactName.text = contact.name
        contactStatus.text = contact.status
        contactImage.image = contact.image
        isSelectedContact = contact.isSelected
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        isSelectedContact.toggle()
        delegate?.didSelectContact(self)
    }
    
    func updateCheckbox() {
        let imageName = isSelectedContact ? "checkbox_checked" : "checkbox_unchecked"
        checkBox.setImage(UIImage(named: imageName), for: .normal)
    }
}
