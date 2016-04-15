//
//  DataService.swift
//  Babylonian
//
//  Created by Dongning Wang on 3/20/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation
import Firebase

@objc class DataService:NSObject {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _COURSE_REF = Firebase(url: "\(BASE_URL)/courses")
    private var _LOCAL_DIR = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    private var _POPULAR_REF = Firebase(url: "\(BASE_URL)/popular_courses")
    private var _TRENDING_REF = Firebase(url: "\(BASE_URL)/trending_courses")
    
    var LOCAL_DIR: String {
        return _LOCAL_DIR
    }
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    var COURSE_REF: Firebase {
        return _COURSE_REF
    }
    
    var POPULAR_REF : Firebase {
        return _POPULAR_REF
    }
    
    var TRENDING_REF : Firebase {
        return _TRENDING_REF
    }
}