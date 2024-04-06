//
//  PassCodeVC.swift
//  Kite messeging
//
//  Created by Admin on 20/03/24.
//

import UIKit

class PassCodeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    @IBOutlet weak var field3: UITextField!
    @IBOutlet weak var field4: UITextField!
    
    @IBAction func backHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtn(_ sender: UIButton) {
        // Navigate to the next page to re-enter the passcode
               let reEnterPasscodeVC = storyboard?.instantiateViewController(withIdentifier: "ReEnterPassCodeVC") as! ReEnterPassCodeVC
               navigationController?.pushViewController(reEnterPasscodeVC, animated: true)
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
    // MARK: - UITextFieldDelegate
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
       
       // Store the passcode in the model class
       private func storePasscode() {
           let passcode = digitTextFields.map { $0.text ?? "" }.joined()
           MyDetails.shared.passcode = passcode
       }

       // UITextFieldDelegate method for handling text field changes
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // If backspace is pressed and the text field is empty, move to the previous one
           if string.isEmpty, range.length > 0, textField.text?.isEmpty == true,
              let previousTextField = previousTextField(for: textField) {
               previousTextField.becomeFirstResponder()
               return false
           }
           
           // Limit input to a single digit
           guard string.count <= 1, let digit = string.first, digit.isNumber else {
               return false
           }
           
           // Update the text field with the entered digit
           textField.text = String(digit)
           
           // Move to the next text field
           if let nextTextField = nextTextField(for: textField) {
               nextTextField.becomeFirstResponder()
           }
           
           // Store the passcode in the model class
           storePasscode()
           
           return false // Prevent further editing
       }
   }
