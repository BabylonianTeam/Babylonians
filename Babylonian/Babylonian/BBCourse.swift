//
//  MinicrouseItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 3/15/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//


import Foundation
import Firebase


class BBCourse: NSObject {
    var Id_: String!
    var title_: String!
    var author_: String!
    var courseItems_: [CourseItem]!
    var ref_: Firebase!

    init(ref: Firebase, author: String) {
        self.author_ = author
        self.ref_ = ref
    }
    
    func setId(id: String) -> Void {
        self.Id_ = id
        self.ref_ = DataService.dataService.COURSE_REF.childByAppendingPath(id)
    }
    
    func setTitle(title: String) -> Void {
        self.title_ = title
    }
    
    var author: String {
        return self.author_
    }
    var title: String {
        return self.title_
    }
    var firebaseRef: Firebase {
        return ref_
    }
    var contents: [CourseItem] {
        return courseItems_
    }
    
    func toAnyObject() -> AnyObject {
        
    return [
        COURSE_TITLE: self.title_,
        COURSE_AUTHOR: self.author_
       
        ]
}
}

