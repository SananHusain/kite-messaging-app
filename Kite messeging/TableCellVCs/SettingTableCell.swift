//
//  SettingTableCell.swift
//  Kite messeging
//
//  Created by Admin on 20/03/24.
//

import UIKit

class SettingTableCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
