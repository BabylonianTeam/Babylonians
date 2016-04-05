//
//  PersonalInfo.swift
//  Babylonian
//
//  Created by Sheng Gan on 4/3/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase

class PersonalInfo{
    
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    
    //get displayName
    func getDisplayName(id: String) -> String{
        /*
        _USER_REF.queryOrderedByChild("displayName").observeEventType(.ChildAdded, withBlock: { snapshot in
            if let displayName = snapshot.value["displayName"] as? String {
                print("\(snapshot.key) is \(displayName)")
                //print(snapshot.key)
            }
            
        })
        */
        var currName = "123"
        _USER_REF.childByAppendingPath(id)?.observeEventType(.Value, withBlock: { snapshot in
            
            if let displayName = snapshot.value["displayName"] as? String {
                print("display name is \(displayName)")
                currName = displayName
                print("currname is \(currName)")
            }
            //return currName
            //print(snapshot.value.objectForKey("displayName"))
            
        })
        //sleep(2)
        print("after call func, currname is \(currName)")
        return currName
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
    
    //update displayName
    func updateDisplayName(id: String, newDisplayName: String){
        let displayNameWrapper = ["displayName": newDisplayName]
        _USER_REF.childByAppendingPath(id)?.updateChildValues(displayNameWrapper)
    }
    
    //update email
    func updateEmail(id: String, newEmail: String){
        let emailWrapper = ["displayName": newEmail]
        _USER_REF.childByAppendingPath(id)?.updateChildValues(emailWrapper)
    }
    
    //update balance
    func updateBalance(id: String, newBalance: Double){
        let balanceWrapper = ["balance": newBalance]
        _USER_REF.childByAppendingPath(id)?.updateChildValues(balanceWrapper)
    }
    
    
}