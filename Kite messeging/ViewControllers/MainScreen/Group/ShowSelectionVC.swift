//
//  ShowSelectionVC.swift
//  Kite messeging
//
//  Created by Admin on 22/03/24.
//

import UIKit

class ShowSelectionVC: UIViewController, UIImagePickerControllerDelegate , UICollectionViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupNameField: UITextField!
    @IBOutlet weak var editContacts: UIButton!
    @IBOutlet weak var contactsCollectionView: UICollectionView!
    @IBOutlet weak var warningLbl: UILabel!
    
    @IBAction func editContactsHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    let groupData = GroupDetails()
    
    @IBAction func menuHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroupMenuInfoVC") as! GroupMenuInfoVC
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    @IBAction func createBtnHit(_ sender: UIButton) {
        // Ensure the groupNameField is not empty
           guard let groupName = groupNameField.text, !groupName.isEmpty else {
               warningLbl.isHidden = false
               return
           }
           
           // Instantiate GroupChatVC from storyboard
           guard let groupChatVC = storyboard?.instantiateViewController(withIdentifier: "GroupChatVC") as? GroupChatVC else {
               return
           }
            // Pass group name and image to GroupChatVC
        groupChatVC.grpName = groupNameField.text ?? ""
        groupChatVC.grpImage = groupImage.image
            // Push GroupChatVC onto navigation stack
            navigationController?.pushViewController(groupChatVC, animated: true)
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set collection view delegate and data source
               contactsCollectionView.delegate = self
               contactsCollectionView.dataSource = self
               
               // Reload the collection view to display selected contacts
               contactsCollectionView.reloadData()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        groupImage.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func changeProfilePicture() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { [weak self] _ in
                self?.presentImagePicker(sourceType: .camera)
            }
            alertController.addAction(cameraAction)
        }
        
        let galleryAction = UIAlertAction(title: "Choose From Gallery", style: .default) { [weak self] _ in
            self?.presentImagePicker(sourceType: .photoLibrary)
        }
        alertController.addAction(galleryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            present(imagePickerController, animated: true, completion: nil)
        } else {
            print("Source type is not available.")
        }
    }
    

}
extension ShowSelectionVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            groupImage.image = pickedImage
            groupData.groupImage = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ShowSelectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SelectedContacts.contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedContactsCollectionCell", for: indexPath) as! SelectedContactsCollectionCell
        
        // Configure cell with contact image
        let contact = SelectedContacts.contacts[indexPath.item]
        cell.configure(with: contact.image)
        
        // Add selected contact to group members
        groupData.groupMembers.append(contact.name)
        
        return cell
    }
}
