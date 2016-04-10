//
//  PersonalInfo.swift
//  Babylonian
//
//  Created by Sheng Gan on 4/3/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation
import Firebase

class PersonalInfo: NSObject{
    var displayName_: String!
    var email_: String!
    var profilePhoto_: String!
    var balance_: Float!
    var ref_: Firebase!
    
    var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    
    init(id: String?){
        if (id != nil){
            self.ref_ = _USER_REF.childByAppendingPath(id)
        }
    }
    
    func setRef(id: String?){
        if (id != nil){
            self.ref_ = _USER_REF.childByAppendingPath(id)
        }
    }
    
    func updateDisplayName(displayName: String) -> Void {
        self.displayName_ = displayName
        self.ref_.updateChildValues([USER_DISPLAYNAME:displayName])
    }
    
    func updateEmail(email: String) -> Void {
        self.email_ = email
        self.ref_.updateChildValues([USER_EMAIL:email])
    }
    
    func updateProfilePhoto(url: String) -> Void {
        self.profilePhoto_ = url
        self.ref_.updateChildValues([USER_PROFILEPHOTO:url])
    }
    
    func updateBalance(balance: Float) -> Void {
        self.balance_ = balance
        self.ref_.updateChildValues([USER_BALANCE: balance])
    }
    
    
    /*
     private var _BASE_REF = Firebase(url: "\(BASE_URL)")
     private var _USER_REF = Firebase(url: "\(BASE_URL)/users")

    //update displayName
    func updateDisplayName(id: String, newDisplayName: String){
        let displayNameWrapper = ["displayName": newDisplayName]
        _USER_REF.childByAppendingPath(id)?.updateChildValues(displayNameWrapper)
    }
    
    //update email
    func updateEmail(id: String, newEmail: String){
        let emailWrapper = ["email": newEmail]
        _USER_REF.childByAppendingPath(id)?.updateChildValues(emailWrapper)
    }
    
    //update balance
    func updateBalance(id: String, newBalance: Double){
        let balanceWrapper = ["balance": newBalance]
        _USER_REF.childByAppendingPath(id)?.updateChildValues(balanceWrapper)
    }
    
    //update password, copy following code
    func updatePassword(email: String, oldPassword: String, newPassword: String){
        _BASE_REF.changePasswordForUser(email, fromOld: oldPassword, toNew: newPassword, withCompletionBlock: { error in
            if (error != nil){
                print("error message")
            }
            else {
                print("Change password successfully")
            }
            
        })
    }
    
    //get displayName
    func getDisplayName(id: String){
        _USER_REF.childByAppendingPath(id)?.observeEventType(.Value, withBlock: { snapshot in
            if let displayName = snapshot.value["displayName"] as? String {
                print("display name is \(displayName)")
            }
        })
    }
    //get email
    func getEmail(id: String){
        _USER_REF.childByAppendingPath(id)?.observeEventType(.Value, withBlock: { snapshot in
            if let email = snapshot.value["email"] as? String {
                print("email is \(email)")
            }
        })
    }
    //get balance
    func getBalance(id: String){
        _USER_REF.childByAppendingPath(id)?.observeEventType(.Value, withBlock: { snapshot in
            if let balance = snapshot.value["balance"] as? String {
                print("balance is \(balance)")
            }
        })
    }
    */
}