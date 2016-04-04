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
        _USER_REF.childByAppendingPath(id).observeEventType(.Value, withBlock: { snapshot in
            
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
}