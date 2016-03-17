//
//  Constants.swift
//  Babylonian
//
//  Created by Ben Freeman on 3/14/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase

let FIREBASE_REF = Firebase(url: "https://babylonian.firebaseio.com")

let USER_REF = FIREBASE_REF.childByAppendingPath("users")

var CURRENT_USER_REF: Firebase {
    if FIREBASE_REF.authData == nil {
        print("No logged in user.")
        return USER_REF
    }
    
    return USER_REF.childByAppendingPath(FIREBASE_REF.authData.uid)
    
}
