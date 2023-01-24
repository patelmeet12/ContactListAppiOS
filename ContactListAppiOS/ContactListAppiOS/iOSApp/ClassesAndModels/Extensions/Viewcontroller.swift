//
//  Viewcontroller.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 24/01/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Take UIImagePickerControllerDelegate & UINavigationControllerDelegate in particular viewcontroller and don't miss to dissmiss picker from this delegate methods
    func openImgePicker() {
        
        func openImagePicker(isCamera: Bool) {
            
            let picker = UIImagePickerController()
            picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.allowsEditing = false
            
            if isCamera {
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    picker.sourceType = .camera
                } else {
                    showAlertWithOkButton(message: "Camera is not supported in your device.")
                    return
                }
            } else {
                picker.sourceType = .photoLibrary
            }
            self.present(vc: picker)
        }
        
        let alertController = UIAlertController(title: "Please select option for pick image!", message: "", preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { (actCam) in
            openImagePicker(isCamera: true)
        }
        alertController.addAction(actionCamera)
        
        let actionGallery = UIAlertAction(title: "Gallery", style: .default) { (actGal) in
            openImagePicker(isCamera: false)
        }
        alertController.addAction(actionGallery)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (actCam) in
            
        }
        alertController.addAction(actionCancel)
        
        self.present(vc: alertController)
    }
    func showAlertWithOkButton(message: String, _ completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: Constant.kAppName, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            completion?()
        }
        alert.addAction(OKAction)
        
        self.present(vc: alert)
    }
    func showAlertWithTwoButtons(message: String, btn1Name: String, btn2Name: String, completion: @escaping ((_ btnClickedIndex: Int) -> Void)) {
        
        let alert = UIAlertController(title: Constant.kAppName, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: btn1Name, style: .default) { (action1) in
            completion(1)
        }
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: btn2Name, style: .default) { (action2) in
            completion(2)
        }
        alert.addAction(action2)
        self.present(vc: alert)
    }
    private func present(vc: UIViewController) {
        
        if let nav = self.navigationController {
            if let presentedVC = nav.presentedViewController {
                presentedVC.present(vc, animated: true, completion: nil)
            } else {
                self.navigationController?.present(vc, animated: true, completion: nil)
            }
        } else {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension String {
    
    func trime() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func isEmoji() -> Bool {
        return (UnicodeScalar(self)?.properties.isEmoji ?? false)
    }
    func isCharacter() -> Bool {
        return (UnicodeScalar(self)?.properties.isAlphabetic ?? false)
    }
    func isDigit() -> Bool {
        return Character(self).isNumber
    }
    
    func isValidEmail() -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    func isValidPhoneNumber() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{9,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
}

extension UITextField {
    
    func isempty() -> Bool {
        return (self.text ?? "").trime().isEmpty
    }
    func trimText() -> String {
        return (self.text ?? "").trime()
    }
    
    func getUpadatedText(string: String, range: NSRange) -> String {
        
        let text = self.text!
        let textRange = Range(range, in: text)!
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        return updatedText
    }
}
