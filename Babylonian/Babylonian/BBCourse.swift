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
    var COURSE_TITLE: String!
    var COURSE_AUTHOR: String!
    var courseItems: [CourseItem]!
    var ref: Firebase!

    init(COURSE_TITLE: String, COURSE_AUTHOR: String) {
        self.COURSE_TITLE = COURSE_TITLE
        self.COURSE_AUTHOR = COURSE_AUTHOR
        self.ref = Minicourse.minicourse.COURSE_REF.childByAppendingPath("refUrl")
    }
    
    
    
    func toAnyObject() -> AnyObject {
        
    return [
        "COURSE_TITLE": COURSE_TITLE,
        "COURSE_AUTHOR": COURSE_AUTHOR
       
        ]
}
}

