//
//  User.swift
//  Babylonian
//
//  Created by Ben Freeman on 3/14/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    var username : String
    var email : String
    var authType : String
    
    init(username : String, email : String, authType : String = "password") {
        self.username = username
        self.email = username
        self.authType = authType
    }
    
    func login(password : String? = nil) {
        switch self.authType {
            case "password":
                self.loginWithPassword()
            case "facebook":
                self.loginWithFacebook()
            case "google":
                self.loginWithGoogle()
            case "twitter":
                self.loginWithTwitter()
            default:
                return
        }
    }
    
    func loginWithPassword() {
        //TODO
    }
    
    func loginWithFacebook() {
        //TODO
    }
    
    func loginWithGoogle() {
        //TODO
    }
    
    func loginWithTwitter() {
        //TODO
    }

}
