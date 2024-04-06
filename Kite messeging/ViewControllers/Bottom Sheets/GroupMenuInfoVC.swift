//
//  GroupMenuInfoVC.swift
//  Kite messeging
//
//  Created by Admin on 26/03/24.
//

import UIKit

class GroupMenuInfoVC: UIViewController {
    
    var groupName: String?
       var groupImage: UIImage?
    
    @IBAction func groupInfoHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroupInfoVC") as! GroupInfoVC
        vc.groupName = groupName
        vc.groupImage = groupImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clearChatHit(_ sender: UIButton) {
        AlertManager.shared.showAlert(title: "Alert", message: "Your chats are cleared", viewController: self)
    }
    
    @IBAction func muteNotiHit(_ sender: UIButton) {
        AlertManager.shared.showAlert(title: "Alert", message: "Notifications are mute", viewController: self)
    }
    
    
    @IBAction func blockHit(_ sender: UIButton) {
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
