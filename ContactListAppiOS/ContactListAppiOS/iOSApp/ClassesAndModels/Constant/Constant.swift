//
//  Constant.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 24/01/23.
//

import Foundation
import UIKit

let userdef = UserDefaults.standard

struct Constant {
    
    public static let kAppName = "Contact App"
}

struct AlertMessage {
    
    public static let profileImg = "Please select your Profile Picture."
    public static let emptyFirstName = "Please enter your First Name."
    public static let emptyLastName = "Please enter your Last Name."
    public static let emptyPhoneNumber = "Please enter your Phone Number."
    public static let validPhoneNumber = "Phone Number must be greater than or equal 10"
    public static let emptyEmail = "Please enter your Email."
    public static let validEmail = "Please enter valid Email."
}
