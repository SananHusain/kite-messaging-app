//
//  EnterNumber.swift
//  Kite messeging
//
//  Created by Admin on 16/03/24.
//

import UIKit
import CountryPickerView
import PhoneNumberKit

class NumberVC: UIViewController{
    
    let phoneNumberKit = PhoneNumberKit()
    let countryPickerView = CountryPickerView()
    let phoneNumberFormatter = PhoneNumberFormatter()
    
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var numberAlert: UILabel!
    
    
    @IBAction func showCountryPicker(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func continueHit(_ sender: UIButton) {
        guard let phoneNumber = phoneNumberField.text, !phoneNumber.isEmpty else {
               numberAlert.isHidden = false
               return
           }
           
        // Check if the selected country is India (IN)
        if countryPickerView.selectedCountry.code == "IN" {
               // If the selected country is India, validate that the phone number contains exactly 10 digits
               if phoneNumber.count != 10 {
                   numberAlert.isHidden = false
                   numberAlert.text = "Please enter a 10-digit phone number."
                   return
               }
           } else {
               // For other countries, validate that the phone number contains exactly 14 digits
               if phoneNumber.count != 13 {
                   numberAlert.isHidden = false
                   numberAlert.text = "Please enter a 10-digit phone number."
                   return
               }
           }
           
           // If the phone number is valid, hide the number alert
           numberAlert.isHidden = true
           // Save the phone number along with the country code in the model class
           let countryCode = countryPickerView.selectedCountry.phoneCode
           let fullPhoneNumber = "\(countryCode)-\(phoneNumber)"
           MyDetails.shared.phoneNumber = fullPhoneNumber
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
        // Set up the countryPickerView
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        phoneNumberField.delegate = self
        updateCountryButtonTitle()
        setDefaultCountry()
        // If no country is selected, set the default country code to +91
          if countryPickerView.selectedCountry == nil {
              countryButton.setTitle("+91", for: .normal)
          }
       }
    func updateCountryButtonTitle() {
        let countryCode = countryPickerView.selectedCountry.code
        countryButton.setTitle(countryCode, for: .normal)
    }
    func setDefaultCountry() {
        // Default country code and flag
        let defaultCountryCode = "+1"
        guard let defaultCountry = countryPickerView.getCountryByCode("US") else {
            return
        }
        let defaultCountryFlag = defaultCountry.flag

        // Set button title to country code
        countryButton.setTitle(defaultCountryCode, for: .normal)

        // Set button image to country flag
        countryButton.setImage(defaultCountryFlag, for: .normal)

        // Adjust image position
        countryButton.imageView?.contentMode = .scaleAspectFit
        countryButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0) // Adjust left inset as needed
    }



}

// MARK: - CountryPickerViewDelegate
extension NumberVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        // Set button title to country code
        countryButton.setTitle(country.phoneCode, for: .normal)

           // Set button image to country flag
           countryButton.setImage(country.flag, for: .normal)
           
           // Adjust image position
           countryButton.imageView?.contentMode = .scaleAspectFit
           countryButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0) // Adjust left inset as needed
       }
}

// MARK: - CountryPickerViewDataSource
extension NumberVC: CountryPickerViewDataSource {
    func showOnlyPreferredCountries(in countryPickerView: CountryPickerView) -> Bool {
        return false // Set to true if you want to show only preferred countries
    }
}
extension NumberVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Calculate the new text after applying the replacement
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return true
        }
        
        var newText = (text as NSString).replacingCharacters(in: range, with: string)
        
        // Remove non-numeric characters from the new text
        let cleanedText = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Set character limit based on the selected country code (10 for IN, 13 for other countries)
        let characterLimit = (countryPickerView.selectedCountry.code == "IN") ? 10 : 13
        
        // Apply character limit
        guard cleanedText.count <= characterLimit else {
            return false // Prevent entering more characters than the limit
        }
        
        // Format the cleaned text into (XXX)XXX-XXXX format for countries other than India
        var formattedNumber = newText
        if countryPickerView.selectedCountry.code != "IN" {
            var index = cleanedText.startIndex
            let format = "(XXX)XXX-XXXX"
            
            formattedNumber = ""
            for character in format where index < cleanedText.endIndex {
                if character == "X" {
                    formattedNumber.append(cleanedText[index])
                    index = cleanedText.index(after: index)
                } else {
                    formattedNumber.append(character)
                }
            }
        }
        
        // Update the text field with the formatted number or the new input text
        textField.text = formattedNumber
        
        return false // Prevent default text replacement behavior
    }
}
