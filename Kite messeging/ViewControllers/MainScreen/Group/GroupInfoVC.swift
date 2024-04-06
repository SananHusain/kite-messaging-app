//
//  GroupInfoVC.swift
//  Kite messeging
//
//  Created by Admin on 26/03/24.
//

import UIKit

class GroupInfoVC: UIViewController{
 
    

    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var ImgGroup: UIImageView!
    @IBOutlet weak var groupMemberTV: UITableView!
    @IBOutlet weak var membersCount: UILabel!
    
    @IBAction func addMembersHit(_ sender: UIButton) {
        //code to add more members
    }

    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    var selectedContacts: [Contact] = [] // Array to store selected contacts
    let groupData = GroupDetails()
    
    var groupName: String?
    var groupImage: UIImage?
    
    @IBAction func exitGroup(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Exit Group", message: "Are you sure you want to exit the group?", preferredStyle: .alert)
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let exitAction = UIAlertAction(title: "Exit", style: .destructive) { _ in NavigationHelper.popBack(3, from: self.navigationController!)
           }
           alertController.addAction(cancelAction)
           alertController.addAction(exitAction)
           present(alertController, animated: true, completion: nil)
       }
    
    var contacts = SelectedContacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupMemberTV.delegate = self
        groupMemberTV.dataSource = self
        nameGroup.text = groupName
        ImgGroup.image = groupImage
        print("Number of contacts: \(SelectedContacts.contacts.count)")
        updateMembersCountLabel()
//        membersCount.text = selectedContacts
    }
    func updateMembersCountLabel() {
        membersCount.text = "\(SelectedContacts.contacts.count) members" // Update the label with the count of selected contacts
    }

}

extension GroupInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectedContacts.contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupMemberCell", for: indexPath) as! GroupMemberCell

        // Get the selected contact
        let contact = SelectedContacts.contacts[indexPath.row]

        // Print the contact data
        print("Contact Name: \(contact.name)")
        print("Contact Status: \(contact.status)")

        // Set the cell properties
        cell.memberName.text = contact.name
        cell.activeStatus.text = contact.status
        cell.memberImage.image = contact.image

        // Set the remove button action
        cell.removeButtonAction = { [weak self] in
        self?.removeMember(at: indexPath)
                }
        
        return cell
    }
    
    // Function to remove a member from the group
       func removeMember(at indexPath: IndexPath) {
           let memberName = SelectedContacts.contacts[indexPath.row].name
           groupData.removeMember(memberName)
           SelectedContacts.contacts.remove(at: indexPath.row) // Remove the member from the selected contacts array
           groupMemberTV.reloadData() // Reload table view to reflect changes
           updateMembersCountLabel() // Update the members count label
       }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
