//
//  MinicrouseItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 3/15/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//


import Foundation
import Firebase


class BBCourse {
    var coursename: String!
    var addedByUser: String!
    var courseItems: [CourseItem]!
    var ref: Firebase!


    
    // Initialize from arbitrary data
    init(coursename: String, addedByUser: String) {//, courseText: NSObject
       // self.coursekey = coursekey
        self.coursename = coursename
        self.addedByUser = addedByUser
        //self.courseItems = courseItems
        self.ref = Minicourse.minicourse.COURSE_REF.childByAppendingPath("refUrl")
    }
    
    
    
    func toAnyObject() -> AnyObject {
        
    return [
        
        "coursename": coursename,
        "addedByUser": addedByUser,
       // "courseItems": courseItems
        
        
        ]
}
}

