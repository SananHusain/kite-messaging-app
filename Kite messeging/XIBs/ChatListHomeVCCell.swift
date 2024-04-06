//
//  ChatListHomeVCCell.swift
//  Kite messeging
//
//  Created by Admin on 19/03/24.
//

import UIKit

class ChatListHomeVCCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMsg: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var msgBadge: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        msgBadge.layer.cornerRadius = msgBadge.frame.width / 2
        msgBadge.clipsToBounds = true
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
