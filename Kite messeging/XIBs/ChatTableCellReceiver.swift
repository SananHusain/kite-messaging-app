//
//  ChatTableCellReceiver.swift
//  Kite messeging
//
//  Created by Admin on 03/04/24.
//

import UIKit

class ChatTableCellReceiver: UITableViewCell {

    
    @IBOutlet weak var chatLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var tickImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
}
