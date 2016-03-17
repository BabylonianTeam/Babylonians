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
    
    //class fields
    private let email : String
    private let authType : String
    private var displayName : String?
    
    
    init(email : String, authType : String = "password", displayName : String? = nil) {
        if displayName != nil {
            self.displayName = displayName!
        }
        self.email = email
        self.authType = authType
    }
    
    func setDisplayName(name : String) {
        self.displayName = name
        self.sendFirebaseData()
    }
    
    func getDisplayName() -> String {
        if self.displayName == nil {
            return "No name set."
        }
        
        return self.displayName!
    }
    
    
    
    //creates a new user in the database using the authentication scheme specified in authType
    func create(password : String? = nil) {
        switch self.authType {
        case "password":
            if (password == nil) {
                print("This authentication type requires a password.")
                return
            }
            else if (self.displayName == nil) {
                print("This authentication type requires a display name to be set")
                return
            }
            self.createWithPassword(password!)
        case "facebook":
            self.createWithFacebook()
        case "google":
            self.createWithGoogle()
        case "twitter":
            self.createWithTwitter()
        default:
            print("Invalid authentication type")
            return
        }
    }
    
    //create a new user using password authentication
    private func createWithPassword(password : String) {
        
        FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
            if error != nil {
                print(error)
            }
            else {
                FIREBASE_REF.authUser(self.email, password: password, withCompletionBlock: { err, authData in
                    let userData = ["provider": authData.provider!, "email": self.email, "displayName": self.displayName!]
                    USER_REF.childByAppendingPath(authData.uid).setValue(userData)
                })
            }
        })
    }
    
    
    private func createWithFacebook() {
        //TODO
    }
    
    
    private func createWithGoogle() {
        //TODO
    }
    
    
    private func createWithTwitter() {
        //TODO
    }
    
    //login existing user using the authentication scheme specified in authType
    func login(password : String? = nil) {
        switch self.authType {
        case "password":
            if (password == nil) {
                print("I need a password to login.")
                return
            }
            self.loginWithPassword(password!)
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
    
    
    private func loginWithPassword(password : String) {
        FIREBASE_REF.authUser(self.email, password: password, withCompletionBlock: { error, authData in
            if error != nil {
                print(error)
            }
            else {
                self.getFirebaseData()
            }
        })
    }
    
    private func loginWithFacebook() {
        //TODO
    }
    
    private func loginWithGoogle() {
        //TODO
    }
    
    private func loginWithTwitter() {
        //TODO
    }
    
    func logout() {
        FIREBASE_REF.unauth()
    }
    
    private func sendFirebaseData() {
        if FIREBASE_REF.authData != nil {
            USER_REF.childByAppendingPath(FIREBASE_REF.authData.uid).updateChildValues(["displayName": self.displayName!])
        }
    }
    
    private func getFirebaseData() {
        if FIREBASE_REF.authData != nil {
            CURRENT_USER_REF.childByAppendingPath("displayName").observeSingleEventOfType(.Value, withBlock: { snapshot in
                self.displayName = snapshot.value as? String
                
            })
        }
    }
}


class Learner : User {

}

class Creator : User {

}
