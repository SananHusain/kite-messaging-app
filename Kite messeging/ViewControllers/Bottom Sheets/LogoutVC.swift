//
//  LogoutVC.swift
//  Kite messeging
//
//  Created by Admin on 20/03/24.
//

import UIKit

class LogoutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancelHit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesHit(_ sender: Any) {
        showAlert(message: "Logged out successfully", duration: 3.0)
        
               // After performing logout action, dismiss the logout view controller
               DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                   self.dismiss(animated: true, completion: nil)
                   
                   NavigationHelper.popBack(3, from: self.navigationController!	)
               }
           }
           
           // Function to show a temporary alert with a given message and duration
           private func showAlert(message: String, duration: TimeInterval) {
               let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
               present(alert, animated: true, completion: nil)
               
               DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                   alert.dismiss(animated: true, completion: nil)
               }
           }
       }
