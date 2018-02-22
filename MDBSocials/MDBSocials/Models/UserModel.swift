//
//  User.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/21/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import Foundation

class UserModel {
    var id: String?
    var name: String?
    var username: String?
    var email: String?
    
    init(id: String, username: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
    }
}
