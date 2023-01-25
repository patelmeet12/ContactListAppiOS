//
//  ContactListTableViewCell.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 23/01/23.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    //MARK:  Outlets and Variable Declarations
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    //MARK: 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK:  Buttons Clicked Actions
    
    //MARK:  Functions
    func configureCell(con: Contact) {
        
        if let img = con.image {
            self.imgContact.image = img
        } else {
            self.imgContact.image = UIImage(named: "ic_profile")
        }
        
        self.lblName.text = con.firstName + " " + con.lastName
        self.lblNumber.text = con.countryCode + " " + con.telephone
    }
}
