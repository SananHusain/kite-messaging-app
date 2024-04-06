//
//  UserData.swift
//  Kite messeging
//
//  Created by Admin on 18/03/24.
//

import Foundation
import UIKit

class UserData {
    static let shared = UserData() // Singleton instance
    
    var phoneNumber: String?
    
    private init() {} // Private initializer to prevent external instantiation
}

class MyDetails: NSObject {
    static let shared = MyDetails() // Singleton instance
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var userImage: Data? // Store the user's profile picture as Data
    var status = ""
    var passcode = ""
    var confirmPasscode = ""
    var phoneNumber: String?
    var passcodeEnabled: Bool = false
    
    private override init() {
        // Prevent instantiation of MyDetails outside of this class
    }
    
    
  
}
class GroupDetails {
    var groupName: String = ""
    var groupImage: UIImage?
    var groupMembers: [String] = []

    // Function to add a member to the group
    func addMember(_ member: String) {
        groupMembers.append(member)
    }

    // Function to remove a member from the group
    func removeMember(_ member: String) {
        if let index = groupMembers.firstIndex(of: member) {
            groupMembers.remove(at: index)
        }
    }
}

class MessagesDetails {
    var senderMsg: [String] = []
    var timestamps: [Date] = []
    var isMessageSent: Bool = false
    var receiverMsg: String?
}
