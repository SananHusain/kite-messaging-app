    //
    //  SelectContactVC.swift
    //  Kite messeging
    //
    //  Created by Admin on 22/03/24.
    //

import UIKit

// Contact struct to represent a contact
struct Contact {
    let name: String
    let status: String
    let image: UIImage? // Assuming the contact image is optional
    var isSelected: Bool // Flag to indicate if the contact is selected or not
    
    init(name: String, status: String, image: UIImage?, isSelected: Bool) {
        self.name = name
        self.status = status
        self.image = image
        self.isSelected = isSelected
    }
}
class SelectedContacts {
    static var contacts: [Contact] = []
}


class SelectContactVC: UIViewController, UICollectionViewDelegate{
    
    @IBOutlet weak var searchFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameGroup: UIButton!
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func searchButtonTapped(_ sender: UIButton){
        focusOnSearchTextField()
    }
    
    @IBOutlet weak var contactCollectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    
    var originalContacts: [Contact] = []
    
    @IBAction func nameGroupHit(_ sender: UIButton) {
        if SelectedContacts.contacts.isEmpty {
            AlertManager.shared.showAlert(title: "No contact selected", message: "Select contacts to proceed ", viewController: self)
        } else {
            // Proceed to the next view controller
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowSelectionVC") as! ShowSelectionVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func menuHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroupMenuInfoVC") as! GroupMenuInfoVC
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    
        // Array to store the contacts
          var contacts: [Contact] = [
            Contact(name: "John Doe", status: "Available", image: UIImage(named: "user1"), isSelected: false),
            Contact(name: "Jane Smith", status: "Busy", image: UIImage(named: "user2"), isSelected: false),
            Contact(name: "Alice Johnson", status: "Away", image: UIImage(named: "user3"), isSelected: false),
            Contact(name: "Bob Brown", status: "Offline", image: UIImage(named: "user4"), isSelected: false),
            Contact(name: "Emily Davis", status: "Available", image: UIImage(named: "user5"), isSelected: false),
            Contact(name: "John Doe", status: "Available", image: UIImage(named: "user1"), isSelected: false),
            Contact(name: "Jane Smith", status: "Busy", image: UIImage(named: "user2"), isSelected: false),
            Contact(name: "Alice Johnson", status: "Away", image: UIImage(named: "user3"), isSelected: false),
            Contact(name: "Bob Brown", status: "Offline", image: UIImage(named: "user4"), isSelected: false),
            Contact(name: "Emily Davis", status: "Available", image: UIImage(named: "user5"), isSelected: false)
          ] // You need to populate this array with your contacts data
          
    override func viewDidLoad() {
        super.viewDidLoad()
        originalContacts = contacts
        
        // Configure table view
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactCollectionView.delegate = self
        contactCollectionView.dataSource = self
        searchField.delegate = self
        collectionViewHeightConstraint.constant = 0
    }
    private func updateCollectionViewHeight() {
           if SelectedContacts.contacts.isEmpty {
               collectionViewHeightConstraint.constant = 0 // Collapse the collection view
           } else {
               // Calculate the desired height based on the number of selected contacts
               // You can set a fixed height or calculate it based on the number of rows or items
               let desiredHeight: CGFloat = 50 // Example fixed height
               collectionViewHeightConstraint.constant = desiredHeight
           }
           // Animate the height change
           UIView.animate(withDuration: 0.3) {
               self.view.layoutIfNeeded()
           }
       }
    func focusOnSearchTextField() {
           searchField.becomeFirstResponder()
       }
    }

extension SelectContactVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableCell", for: indexPath) as! ContactTableCell
        let contact = contacts[indexPath.row]
        cell.configure(with: contact)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension SelectContactVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Toggle the selection state of the contact
        contacts[indexPath.row].isSelected.toggle()
        
        if contacts[indexPath.row].isSelected {
            // Add the newly selected contact to the selected contacts array
            SelectedContacts.contacts.append(contacts[indexPath.row])
        } else {
            // Remove the deselected contact from the selected contacts array
            if let index = SelectedContacts.contacts.firstIndex(where: { $0.name == contacts[indexPath.row].name }) {
                SelectedContacts.contacts.remove(at: index)
            }
        }
        
        // Update the collection view's height
        updateCollectionViewHeight()
        
        // Reload the collection view to reflect the changes in selected contacts
        contactCollectionView.reloadData()
        
        // Reload the table view to update the checkbox state
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


extension SelectContactVC: ContactTableViewCellDelegate {
    func didSelectContact(_ cell: ContactTableCell) {
        guard let indexPath = contactTableView.indexPath(for: cell) else { return }
        contacts[indexPath.row].isSelected = cell.isSelectedContact
        
        // Reload the cell to update the checkbox state
        contactTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension SelectContactVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SelectedContacts.contacts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCollectionCell", for: indexPath) as! ContactCollectionCell
        let contact = SelectedContacts.contacts[indexPath.item]
        cell.configure(with: contact)

        return cell
    }
}

extension SelectContactVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let searchText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        if searchText.isEmpty {
            // If the search text is empty, show all contacts
            contacts = originalContacts
        } else {
            // Filter the contacts based on the search text
            contacts = originalContacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        // Reload the table view to reflect the filtered contacts
        contactTableView.reloadData()
        
        return true
    }
}

