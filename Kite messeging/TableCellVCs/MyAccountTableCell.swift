//
//  MyAccountTableCell.swift
//  Kite messeging
//
//  Created by Admin on 20/03/24.
//

import UIKit

protocol MyAccountTableCellDelegate: AnyObject {
    func editButtonTapped(in cell: MyAccountTableCell)
}

class MyAccountTableCell: UITableViewCell {
    weak var delegate: MyAccountTableCellDelegate?
    
    @IBAction func editHit(_ sender: UIButton) {
        delegate?.editButtonTapped(in: self)
    }
    
    

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
