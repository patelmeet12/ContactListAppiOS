//
//  AddContactVC.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 24/01/23.
//

import UIKit

class AddEditContactVC: UIViewController {
    
    //MARK:  Outlets and Variable Declarations
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var isImageEdit: Bool = false
    
    enum IsFrom {
        case add
        case edit
    }
    
    var isFrom: IsFrom = .add
    
    //Getting from ContactDetailVC when click on btnEditClicked
    var contact: Contact?
    
    //MARK: 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
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
            
            var con = Contact(image: imgProfile.image, firstName: txtFirstName.trimText(), lastName: txtLastName.trimText(), email: txtEmail.trimText(), countryCode: txtCountryCode.trimText(), telephone: txtPhoneNumber.trimText())
            
            if contact == nil { // Check came for edit contact or add new contact
                
                contactManager.saveContact(contact: con) { isSuccess, message in
                    
                    if isSuccess {
                        
                        CoreDataManager.shared.insertContact(contact: con) { isSuccess, message in
                            
                            if isSuccess {
                                self.showAlertWithOkButton(message: message) {
                                    
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                            } else {
                                
                                self.showAlertWithOkButton(message: message)
                            }
                        }
                        
                    } else {
                        
                        self.showAlertWithOkButton(message: message)
                    }
                }
            } else {
                
                con.contactId = contact?.contactId
                
                CoreDataManager.shared.updateContact(con: con) { isSuccess, message in
                    
                    if isSuccess {
                        self.showAlertWithOkButton(message: message) {
                            
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    } else {
                        self.showAlertWithOkButton(message: message)
                    }
                }
            }
        }
    }
    
    //MARK:  Functions
    private func initialSetup() {
        
        let title = isFrom == .add ? "Add Contact":"Edit Contact"
        self.lblTitle.text = title
        
        let submit = isFrom == .add ? "Submit":"Update"
        self.btnSubmit.setTitle(submit, for: .normal)
        
        self.setContactDetails()
    }
    
    private func setContactDetails() {
        
        if let con = self.contact {
            
            if let img = con.image {
                
                self.isImageEdit = true
                self.imgProfile.image = img
            }
            self.txtFirstName.text = con.firstName
            self.txtLastName.text = con.lastName
            self.txtCountryCode.text = con.countryCode
            self.txtPhoneNumber.text = con.telephone
            self.txtEmail.text = con.email
        }
    }
    
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
extension AddEditContactVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
extension AddEditContactVC: CircleCropViewControllerDelegate {
    
    func circleCropDidCancel() {
        
        print("User canceled the crop flow")
    }
    
    func circleCropDidCropImage(_ image: UIImage) {
        
        self.imgProfile.image = image
    }
}

//MARK:  UITextFieldDelegate Methods
extension AddEditContactVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
            
        case txtCountryCode:
            
            let countryCodeVC = storyboard?.instantiateViewController(withIdentifier: "CountryCodeVC") as! CountryCodeVC
            if #available(iOS 15.0, *) {
                countryCodeVC.sheetPresentationController?.prefersGrabberVisible = true
            } else {
                // Fallback on earlier versions
            }
            countryCodeVC.modalPresentationStyle = .overFullScreen
            countryCodeVC.getSelectedOption = { (selectedOption) in
                self.txtCountryCode.text = selectedOption
            }
            present(countryCodeVC, animated: true, completion: nil)
            
            textField.resignFirstResponder()
            
        default:
            break
        }
    }
    
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
