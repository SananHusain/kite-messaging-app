//
//  CallListCell.swift
//  Kite messeging
//
//  Created by Admin on 19/03/24.
//

import UIKit

class CallListCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var callArrow: UIImageView!
    @IBOutlet weak var callTime: UILabel!
    @IBOutlet weak var callIcon: UIButton!
    
    var delegate: CallListCellDelegate?
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
           callIcon.addTarget(self, action: #selector(callIconTapped), for: .touchUpInside)
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func callIconTapped() {
        delegate?.didTapCallIcon(in: self)
    }

}
protocol CallListCellDelegate: AnyObject {
    func didTapCallIcon(in cell: CallListCell)
}
