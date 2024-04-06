//
//  CallScreenVC.swift
//  Kite messeging
//
//  Created by Admin on 29/03/24.
//

import UIKit

class CallScreenVC: UIViewController {

    var selectedCallData: CallData?
    @IBAction func disconnectBtnHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedCallData = selectedCallData {
            userName.text = selectedCallData.UName
            userImage.image = selectedCallData.UImage
        }
    }

}
