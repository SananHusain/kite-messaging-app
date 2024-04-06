//
//  PhoneNumberFormatter.swift
//  Kite messeging
//
//  Created by Admin on 28/03/24.
//
import Foundation

class PhoneNumberFormatter {
    func format(phoneNumber: String) -> String {
        // Remove non-numeric characters from the phone number string
        let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Check if the cleaned phone number is empty
        guard !cleanedPhoneNumber.isEmpty else {
            return ""
        }
        
        // Format the phone number
        var formattedPhoneNumber = ""
        let areaCodeLength = min(cleanedPhoneNumber.count, 3)
        let startIndex = cleanedPhoneNumber.startIndex
        let areaCodeIndex = cleanedPhoneNumber.index(startIndex, offsetBy: areaCodeLength)
        let areaCode = String(cleanedPhoneNumber[startIndex..<areaCodeIndex])
        formattedPhoneNumber.append("(" + areaCode)
        
        if cleanedPhoneNumber.count > 3 {
            let prefixLength = min(cleanedPhoneNumber.count - 3, 3)
            let prefixIndex = cleanedPhoneNumber.index(startIndex, offsetBy: areaCodeLength)
            let prefix = String(cleanedPhoneNumber[prefixIndex..<cleanedPhoneNumber.index(prefixIndex, offsetBy: prefixLength)])
            formattedPhoneNumber.append(") " + prefix)
        }
        
        if cleanedPhoneNumber.count > 6 {
            let remainingDigits = String(cleanedPhoneNumber.suffix(from: cleanedPhoneNumber.index(startIndex, offsetBy: 6)))
            formattedPhoneNumber.append("-" + remainingDigits)
        }
        
        return formattedPhoneNumber
    }
}

