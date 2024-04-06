//
//  ContactScreenVC.swift
//  Kite messeging
//
//  Created by Admin on 21/03/24.
//

import UIKit
import SafariServices
import MessageUI


class ContactScreenVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    var user: User?
    
    @IBAction func backHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    
    @IBAction func emailBtnHit(_ sender: UIButton) {
        emailPopup()
    }
    
    
    @IBAction func blockHt(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BlockPopupVC") as! BlockPopupVC
        vc.user = self.user
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            image.image = user.image
            contactName.text = user.name
            contactNumber.text = user.phoneNumber
            contactEmail.text = user.email
            // Add tap gesture recognizer to the phone number label
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(phoneNumberLabelTapped))
            contactNumber.isUserInteractionEnabled = true
            contactNumber.addGestureRecognizer(tapGesture)
            
            let emailTapGesture = UITapGestureRecognizer(target: self, action: #selector(emailLabelTapped))
            contactEmail.isUserInteractionEnabled = true
            contactEmail.addGestureRecognizer(emailTapGesture)
            
            
        }
    }
    @objc func phoneNumberLabelTapped() {
        // Check if a phone number is available
        guard let phoneNumber = contactNumber.text, !phoneNumber.isEmpty else {
            return
        }
        
        // Create an alert controller
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Add action to copy phone number
        let copyAction = UIAlertAction(title: "Copy Phone Number", style: .default) { _ in
            UIPasteboard.general.string = phoneNumber
        }
        alertController.addAction(copyAction)
        
        // Add action to manually call the phone number
        let callAction = UIAlertAction(title: "Call \(phoneNumber)", style: .default) { _ in
            // Display an alert indicating that the call cannot be made from the simulator
            let alert = UIAlertController(title: "Unable to Make Call", message: "Phone calls cannot be made from the iOS Simulator. Please use a physical device to make calls.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        alertController.addAction(callAction)
        
        // Add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    @objc func emailLabelTapped() {
        // Check if an email is available
        guard let email = contactEmail.text, !email.isEmpty else {
            return
        }
        
        // Check if the device is capable of sending emails
        guard MFMailComposeViewController.canSendMail() else {
            // Device is not configured to send emails, handle the error
            AlertManager.shared.showAlert(title: "No App Found", message: "Your device is not configured to send email please try using a physical device", viewController: self)
            return
        }
        
        // Open email client
        if let emailURL = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        } else {
            // Handle error or display alert if email client is not available
            print("Unable to compose email.")
        }
    }
    func emailPopup() {
        guard MFMailComposeViewController.canSendMail() else {
            // Device is not configured to send emails, handle the error
            AlertManager.shared.showAlert(title: "No App Found", message: "Your device is not configured to send email. Please try using a physical device.", viewController: self)
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["address@example.com"])
        composeVC.setSubject("Hello!")
        composeVC.setMessageBody("Hello from California!", isHTML: false)
        
        // Check if MFMailComposeViewController is not nil before presenting it
        if composeVC != nil {
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("MFMailComposeViewController is nil.")
        }
    }
    
    
    
    private func mailComposeController(controller: MFMailComposeViewController,
                                       didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
}
