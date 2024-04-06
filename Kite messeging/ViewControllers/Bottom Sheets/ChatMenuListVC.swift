//
//  ChatMenuListVC.swift
//  Kite messeging
//
//  Created by Admin on 21/03/24.
//

import UIKit

class ChatMenuListVC: UIViewController {
    
    var user: User?

    let alert = AlertManager.shared
    
    @IBAction func viewContactBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactScreenVC") as! ContactScreenVC
        vc.user = self.user // Pass the user object to ContactScreenVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clearChat(_ sender: UIButton) {
        alert.showAlert(title: "Clear Chat", message: "All the chats will be cleared", viewController: self)
    }
    
    @IBAction func muteNotification(_ sender: UIButton) {
        alert.showAlert(title: "Notifications", message: "All the notifications are mute", viewController: self)
    }
    @IBAction func blockBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BlockPopupVC") as! BlockPopupVC
        vc.user = self.user
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
