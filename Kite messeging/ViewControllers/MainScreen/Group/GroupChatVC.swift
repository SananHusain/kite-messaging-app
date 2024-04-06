//
//  GroupChatVC.swift
//  Kite messeging
//
//  Created by Admin on 22/03/24.
//

import UIKit

class GroupChatVC: UIViewController {

    @IBOutlet weak var selfGroupImage: UIImageView!
    
    @IBOutlet weak var selfGroupName: UILabel!
    
    @IBAction func menuBtnHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroupMenuInfoVC") as! GroupMenuInfoVC
        vc.groupName = selfGroupName.text
        vc.groupImage = selfGroupImage.image
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    
    @IBAction func backHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func audioCallHit(_ sender: UIButton) {
    }
    
    @IBAction func videoCallHit(_ sender: UIButton) {
    }

    var grpName: String?
       var grpImage: UIImage?

       override func viewDidLoad() {
           super.viewDidLoad()
           // Set group name and image
              selfGroupName.text = grpName
              selfGroupImage.image = grpImage
           print(GroupDetails())
       }
   }
