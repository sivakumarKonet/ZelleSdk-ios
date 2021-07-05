//
//  Contact.swift
//  ZelleSDK
//
//  Created by Jayant Tiwari on 01/07/21.
//  Copyright © 2021 Fiserv. All rights reserved.
//

import UIKit

struct Contact : Codable {
    
    var name : String
    var phoneNumber : [String]
    var emailAddress : [String]
    
    init(name : String, phoneNumber : [String], emailAddress : [String]) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        
    }
}
