//
//  ContactCollectionVC.swift
//  Kite messeging
//
//  Created by Admin on 28/03/24.
//

import UIKit

class ContactCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var contactImage: UIImageView!
    func configure(with contact: Contact) {
        contactImage.image = contact.image
      }
    
}
