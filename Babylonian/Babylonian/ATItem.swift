//
//  ATItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation

class ATItem: CourseItem {
     var courseText: NSObject!
     var courseAudio: String!
    
    init(courseText: NSObject, courseAudio: String, order: Int, courseId: String) {//, courseText: NSObject
        super.init()
        self.courseText = courseText
        self.courseAudio = courseAudio
        self.order = order
        self.courseId = courseId
        // self.tag = tag
       // self.ref = Minicourse.minicourse.COURSE_REF.childByAppendingPath("refUrl")
    }
    
    func toAnyObject() -> AnyObject {
        
        return [
            
            "courseAudio": courseAudio,
            "courseText": courseText,
            "order": order,
            "courseId": courseId

        ]
    }

    
    
}