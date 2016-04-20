//
//  ownedCourse.swift
//  Babylonian
//
//  Created by Sheng Gan on 4/14/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation
import Firebase

//TODO: for wrapping purchased course including date
class OwnedCourseItem: NSObject{
    var ownedDate: String!
    //var createdDate: String!      //for creator
    //var purchasedDate: String!    //for learner
    var ref_: Firebase!
    
    init(ref: Firebase!, ownedDate: String){
        self.ref_ = ref
        self.ownedDate = ownedDate
    }
    
    var ownedCourseRef: Firebase{
        return self.ref_
    }
    
    func getType() -> String{
        //this function need to be overriden
        fatalError("Must Override")
    }
    
    func toAnyObject() -> AnyObject{
        //this function need to be overriden
        fatalError("Must Override")
    }
    
}