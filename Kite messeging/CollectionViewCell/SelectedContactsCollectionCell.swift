//
//  SelectedContactsCollectionCell.swift
//  Kite messeging
//
//  Created by Admin on 22/03/24.
//

import UIKit

class SelectedContactsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var contactImage: UIImageView!
    func configure(with image: UIImage?) {
            contactImage.image = image
        }
}
