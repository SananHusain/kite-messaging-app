//
//  PersonalMenuVC.swift
//  Kite messeging
//
//  Created by Admin on 19/03/24.
//

import UIKit

class PersonalMenuVC: UIViewController {

    
    @IBAction func myAccountHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountVC") as! MyAccountVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func settingHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func logoutHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
          // Dismiss the presented view controller
          dismiss(animated: true, completion: nil)
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Add tap gesture recognizer to the view
          let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
          view.isUserInteractionEnabled = true // Ensure user interaction is enabled
          view.addGestureRecognizer(tapGestureRecognizer)
      }
  }
