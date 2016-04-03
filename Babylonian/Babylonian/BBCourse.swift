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
    var title: String!
    var author: String!
    var courseItems: [CourseItem]!
    var ref: Firebase!

    init(title: String, author: String) {
        self.title = title
        self.author = author
        //self.ref = Minicourse.minicourse.COURSE_REF.childByAppendingPath("refUrl")
    }
    
    
    
    func toAnyObject() -> AnyObject {
        
    return [
        COURSE_TITLE: self.title,
        COURSE_AUTHOR: self.author
       
        ]
}
}

