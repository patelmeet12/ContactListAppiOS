//
//  ContactDetailsVC.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 25/01/23.
//

import UIKit

class ContactDetailsVC: UIViewController {
    
    //MARK:  Outlets and Variable Declarations
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var contact: Contact?
    
    //MARK: 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setContactDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK:  Buttons Clicked Actions
    @IBAction func btnBackClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditClicked(_ sender: UIButton) {
        
        let addContactVC = storyboard?.instantiateViewController(withIdentifier: "AddContactVC") as! AddEditContactVC
        addContactVC.isFrom = .edit
        addContactVC.contact = contact
        self.navigationController?.pushViewController(addContactVC, animated: true)
    }
    
    //MARK:  Functions
    func setContactDetails() {
        
        if let con = contact {
            if let img = con.image {
                self.imgProfile.image = img
            } else {
                self.imgProfile.image = UIImage(named: "ic_profile")
            }
            
            self.lblFullName.text = con.firstName + " " + con.lastName
            self.lblPhoneNumber.text = con.countryCode + " " + con.telephone
            self.lblEmail.text = con.email
        }
    }
}
