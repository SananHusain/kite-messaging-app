//
//  MyAccountVC.swift
//  Kite messeging
//
//  Created by Admin on 20/03/24.
//

import UIKit

class MyAccountVC: UIViewController, MyAccountTableCellDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var userPhoto: UIImageView!
    

    @IBOutlet weak var accountTableView: UITableView!
    
    @IBAction func backHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editHit(_ sender: UIButton) {
        changeProfilePicture()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountTableView.dataSource = self
        accountTableView.delegate = self
        
        // Display the user's photo
        if let imageData = MyDetails.shared.userImage {
            // Convert the image data to a UIImage
            if let image = UIImage(data: imageData) {
                // Assign the UIImage to the userPhoto image view
                userPhoto.image = image
            } else {
                // Use a placeholder image if conversion fails
                userPhoto.image = UIImage(systemName: "person.fill")
            }
        } else {
            // Use a placeholder image if userImageData is nil
            userPhoto.image = UIImage(systemName: "person.fill")
        }

    }
    


}
extension MyAccountVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAccountTableCell", for: indexPath) as! MyAccountTableCell
        
        cell.delegate = self
        
        switch indexPath.row {
        case 0:
            // User name cell
            cell.userImage.image = UIImage(systemName: "person.fill")
            cell.userName.text = "\(MyDetails.shared.firstName) \(MyDetails.shared.lastName)"
            cell.editBtn.isHidden = false // Hide edit button for profile picture
        case 1:
            // Status Cell
            cell.userName.text = "Write About Yourself"
            cell.userImage.image = UIImage(named: "status") // Use appropriate image
            if MyDetails.shared.status.isEmpty {
                cell.userName.text = "Live your life 100%" // Set default text
               } else {
                   cell.userName.text = MyDetails.shared.status
               }
               
            cell.editBtn.isHidden = false // Show edit button for name
        case 2:
            // Phone Number
            cell.userImage.image = UIImage(named: "Acall") // Use appropriate image
            cell.userName.text = MyDetails.shared.phoneNumber // Use phone number if available
            cell.editBtn.isHidden = true // Show edit button for status
        default:
            fatalError("Unexpected indexPath")
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           // Set a fixed height for all cells
           return 90 // Adjust the height as needed
       }
    }
// MARK: - MyAccountTableCellDelegate

extension MyAccountVC {
    func editButtonTapped(in cell: MyAccountTableCell) {
        guard let indexPath = accountTableView.indexPath(for: cell) else { return }
        
        switch indexPath.row {
        case 0:
            // Edit User Name
            presentEditNameAlert()
        case 1:
            // Edit Status
            presentEditStatusAlert()
        default:
            break
        }
    }
    
    private func presentEditNameAlert() {
        let alertController = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "First Name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Last Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let firstName = alertController.textFields?[0].text,
               let lastName = alertController.textFields?[1].text {
                MyDetails.shared.firstName = firstName
                MyDetails.shared.lastName = lastName
                self?.accountTableView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentEditStatusAlert() {
        let alertController = UIAlertController(title: "Edit Status", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter your status"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let status = alertController.textFields?.first?.text {
                MyDetails.shared.status = status
                self?.accountTableView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // Set the selected image to the userPhoto image view
            userPhoto.image = selectedImage
            
            // Convert the UIImage to Data and store it in MyDetails.shared.userImage
            if let imageData = selectedImage.pngData() {
                MyDetails.shared.userImage = imageData
            }
        }
        
        // Dismiss the image picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the image picker when canceled
        picker.dismiss(animated: true, completion: nil)
    }
}


