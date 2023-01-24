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
    func configureCell(con: String) {
        
    }
}
