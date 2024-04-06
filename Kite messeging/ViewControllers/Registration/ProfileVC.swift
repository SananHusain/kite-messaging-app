//
//  ProfileVC.swift
//  Kite messeging
//
//  Created by Admin on 18/03/24.
//

import UIKit

class ProfileVC: UIViewController{
    
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var nameAlert: UILabel!
    @IBOutlet weak var lastNameAlert: UILabel!
    let maxNameLength = 60 // Maximum allowed characters for first name and last name
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Add tap gesture recognizer to the profile picture image view
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
           addPhotoHit.isUserInteractionEnabled = true
           addPhotoHit.addGestureRecognizer(tapGesture)
        firstNameField.delegate = self
        lastNameField.delegate = self
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
    @IBOutlet weak var addPhotoHit: UIImageView!
    @IBAction func backHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueHit(_ sender: UIButton) {
        // Check if first name is empty
          guard let firstName = firstNameField.text, !firstName.isEmpty else {
              nameAlert.isHidden = false
              return
          }
          
          // Check if last name is empty
          guard let lastName = lastNameField.text, !lastName.isEmpty else {
              lastNameAlert.isHidden = false
              return
          }
          
          // Hide the alert labels
          nameAlert.isHidden = true
          lastNameAlert.isHidden = true
          
          // Store the first name and last name entered by the user
          MyDetails.shared.firstName = firstName
          MyDetails.shared.lastName = lastName
          
          // Proceed to the next view controller
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
          self.navigationController?.pushViewController(vc, animated: true)
      }
    
    
    @IBAction func changeBtnHit(_ sender: UIButton) {
    changeProfilePicture()
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            addPhotoHit.image = pickedImage
            
        // Convert the image to data and store it in MyDetails
        MyDetails.shared.userImage = pickedImage.jpegData(compressionQuality: 0.8)
                
        }
        addPhotoHit.isUserInteractionEnabled = false
        changePhotoButton.isHidden = false // Show the button after selecting the image

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension ProfileVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        // Check which text field is being edited
        if textField == firstNameField {
            // Check the maximum length for the first name field
            let maxLength = maxNameLength
            let newLength = text.count + string.count - range.length
            
            if newLength > maxLength {
                return false // Prevent the user from entering more characters
            }
            else if string.contains(" "){
                return false
            }
        } else if textField == lastNameField {
            // Check the maximum length for the last name field
            let maxLength = maxNameLength
            let newLength = text.count + string.count - range.length
            
            if newLength > maxLength {
                return false // Prevent the user from entering more characters
            }
        }
        
        return true // Allow the change if within the maximum length
    }
}
