//
//  ReEnterPassCodeVC.swift
//  Kite messeging
//
//  Created by Admin on 20/03/24.
//

import UIKit

class ReEnterPassCodeVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var SuccessAlert: UIView!
    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    @IBOutlet weak var field3: UITextField!
    @IBOutlet weak var field4: UITextField!
    
    @IBAction func backHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var digitTextFields: [UITextField] = [field1, field2, field3, field4]
       
       override func viewDidLoad() {
           super.viewDidLoad()
           // Set the view controller as the delegate for each text field
           digitTextFields.forEach { textField in
               textField.delegate = self
               // Style text fields
               textField.layer.cornerRadius = 15
               textField.layer.borderWidth = 1
               textField.layer.borderColor = UIColor.black.cgColor
               textField.textAlignment = .center
           }
       }
    
    @IBAction func setCodeHit(_ sender: UIButton) {
        // Check if the entered passcode matches the stored passcode
               if isPasscodeCorrect() {
                   // Show success alert for 5 seconds
                   SuccessAlert.isHidden = false
                   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                       self.SuccessAlert.isHidden = true
                       NavigationHelper.popBack(3, from: self.navigationController!)

                   }
               } else {
                   // Show error message (e.g., incorrect passcode)
                   showAlert(message: "Incorrect passcode")
               }
           }
    // Check if the entered passcode matches the stored passcode
       func isPasscodeCorrect() -> Bool {
           let enteredPasscode = digitTextFields.map { $0.text ?? "" }.joined()
           let storedPasscode = MyDetails.shared.passcode 
           return enteredPasscode == storedPasscode
       }
       
       // Helper method to display an alert with a message
       func showAlert(message: String) {
           let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
       
       // Limit input to a single digit and automatically move to the next field
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // If backspace is pressed, clear the text field and move to the previous one
           if string.isEmpty, let previousTextField = previousTextField(for: textField) {
               previousTextField.becomeFirstResponder()
               previousTextField.text = ""
               return false
           }
           
           // Limit input to a single digit
           guard string.count == 1, let digit = string.first, digit.isNumber else {
               return false
           }
           
           // Update the text field with the entered digit
           textField.text = String(digit)
           
           // Move to the next text field
           if let nextTextField = nextTextField(for: textField) {
               nextTextField.becomeFirstResponder()
           }
           
           return false // Prevent further editing
       }
       
       // Helper method to get the previous text field
       private func previousTextField(for textField: UITextField) -> UITextField? {
           guard let currentIndex = digitTextFields.firstIndex(of: textField),
                 currentIndex > 0 else {
               return nil
           }
           return digitTextFields[currentIndex - 1]
       }

       // Helper method to get the next text field
       private func nextTextField(for textField: UITextField) -> UITextField? {
           guard let currentIndex = digitTextFields.firstIndex(of: textField),
                 currentIndex < digitTextFields.count - 1 else {
               return nil
           }
           return digitTextFields[currentIndex + 1]
       }
   }

