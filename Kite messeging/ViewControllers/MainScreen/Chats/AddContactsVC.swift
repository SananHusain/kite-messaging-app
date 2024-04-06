//
//  HomeVC.swift
//  Kite messeging
//
//  Created by Admin on 18/03/24.
//

import UIKit

class AddContactsVC: UIViewController {

    
    @IBAction func menuBtnHit(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonalMenuVC") as! PersonalMenuVC
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonalMenuVC") as? PersonalMenuVC else {
//               return
//           }
//
//           // Set up bottom sheet presentation
//           let sheet = vc.sheetPresentationController
//           sheet?.detents = [.medium()]
//           sheet?.prefersScrollingExpandsWhenScrolledToEdge = false
//           sheet?.prefersGrabberVisible = true
//           sheet?.preferredCornerRadius = 40
//
//           // Present the view controller as a bottom sheet
//           if let presentationController = vc.presentationController as? UISheetPresentationController {
//               presentationController.detents = [.medium()]
//           }
//
//           // Present the view controller
//        self.navigationController?.pushViewController(vc, animated: true)
       
           }
    
    
    
    @IBAction func addContacts(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatListVC") as! ChatListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
   

}


