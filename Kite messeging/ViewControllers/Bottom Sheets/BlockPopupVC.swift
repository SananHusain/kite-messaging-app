//
//  BlockPopupVC.swift
//  Kite messeging
//
//  Created by Admin on 21/03/24.
//

import UIKit

class BlockPopupVC: UIViewController {

    @IBOutlet weak var blockLbl: UILabel!
    var user: User?
    
    @IBAction func cancelHit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func blockHit(_ sender: UIButton) {
        AlertManager.shared.showAlert(title: "Contact Blocked", message: "You can unblock anytime" , viewController: self)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
          // Dismiss the presented view controller
          dismiss(animated: true, completion: nil)
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
          blockLbl.text = "Are you sure you want to block \(user!.name)"
          // Add tap gesture recognizer to the view
          let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
          view.isUserInteractionEnabled = true // Ensure user interaction is enabled
          view.addGestureRecognizer(tapGestureRecognizer)
      }

}
