//
//  GroupInitVC.swift
//  Kite messeging
//
//  Created by Admin on 21/03/24.
//

import UIKit

class GroupInitVC: UIViewController {
    
    
    @IBAction func createGroupHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectContactVC") as! SelectContactVC
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func menuHit(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroupMenuInfoVC") as! GroupMenuInfoVC
//        let navigationController_temp = UINavigationController(rootViewController: vc)
//        navigationController_temp.navigationBar.isHidden = true
//        navigationController_temp.modalPresentationStyle = .overFullScreen
//        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
   

}
