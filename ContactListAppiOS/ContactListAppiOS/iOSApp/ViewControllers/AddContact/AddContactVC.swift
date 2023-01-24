//
//  AddContactVC.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 24/01/23.
//

import UIKit

class AddContactVC: UIViewController {
    
    //MARK:  Outlets and Variable Declarations
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var isImageEdit: Bool = false
    
    //MARK: 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK:  Buttons Clicked Actions
    @IBAction func btnBackClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnProfilePhotoClicked(_ sender: UIButton) {
        
        self.openImgePicker()
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        if isValidFields() {
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK:  Functions
    private func isValidFields() -> Bool {
        
        if isImageEdit == false {
            self.showAlertWithOkButton(message: AlertMessage.profileImg)
            
        } else if txtFirstName.isempty() {
            self.showAlertWithOkButton(message: AlertMessage.emptyFirstName)
            
        } else if txtLastName.isempty() {
            self.showAlertWithOkButton(message: AlertMessage.emptyLastName)
            
        } else if txtPhoneNumber.isempty() {
            self.showAlertWithOkButton(message: AlertMessage.emptyPhoneNumber)
            
        } else if !txtPhoneNumber.isempty() && !txtPhoneNumber.text!.trime().isValidPhoneNumber() {
            self.showAlertWithOkButton(message: AlertMessage.validPhoneNumber)

        } else if txtEmail.isempty() {
            self.showAlertWithOkButton(message: AlertMessage.emptyEmail)
            
        } else if !txtEmail.text!.trime().isValidEmail() {
            self.showAlertWithOkButton(message: AlertMessage.validEmail)
            
        } else {
            return true
        }
        return false
    }
}

//MARK:  UIImagePickerControllerDelegate Methods
extension AddContactVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage {
            
            self.isImageEdit = true
            self.openCropVC(image: img)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    private func openCropVC(image: UIImage) {
        
        let circleCropController = CircleCropViewController()
        circleCropController.image = image
        circleCropController.delegate = self
        present(circleCropController, animated: true, completion: nil)
    }
}

//MARK:  CircleCropViewControllerDelegate Methods
extension AddContactVC: CircleCropViewControllerDelegate {
    
    func circleCropDidCancel() {
        
         print("User canceled the crop flow")
    }
    
    func circleCropDidCropImage(_ image: UIImage) {
        
        self.imgProfile.image = image
    }
}

//MARK:  UITextFieldDelegate Methods
extension AddContactVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let updatedText = textField.getUpadatedText(string: string, range: range)
                   
        switch textField {
        case txtEmail:
            return !string.isEmoji() || !string.trime().isEmpty
    
        default:
            break
        }
        
        return true
    }
}
