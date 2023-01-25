//
//  CountryCodeTableViewCell.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 26/01/23.
//

import UIKit

class CountryCodeTableViewCell: UITableViewCell {
    
    //MARK:  Outlets and Variable Declarations
    @IBOutlet weak var lblCountryCode: UILabel!
    
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
        
        self.lblCountryCode.text = con.firstName + " " + con.lastName
    }
}
