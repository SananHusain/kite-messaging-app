//
//  ChatTableCell.swift
//  Kite messeging
//
//  Created by Admin on 01/04/24.
//

import UIKit

class ChatTableCellSender: UITableViewCell {

    
    @IBOutlet weak var msgLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var sentImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
