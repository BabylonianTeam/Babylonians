 //
//  ATItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation

class ATItem: CourseItem {
    
    init(courseText: String, courseAudio: String, order: Int) {//, courseText: NSObject
        super.init()
        
        self.content = [COURSE_ITEM_TEXT:courseText,COURSE_ITEM_AUDIO:courseAudio]
        self.order = order
        self.courseId = courseId
        // self.tag = tag
       // self.ref = Minicourse.minicourse.COURSE_REF.childByAppendingPath("refUrl")
    }
    
    override func getType() -> String {
        return COURSE_ITEM_TYPE_AUDIOTEXT
    }
    
    func toAnyObject() -> AnyObject {
        
        return [
            
            COURSE_ITEM_AUDIO: self.content[COURSE_ITEM_AUDIO] as! String,
            COURSE_ITEM_TEXT: self.content[COURSE_ITEM_TEXT] as! String,
            COURSE_ITEM_ORDER: order,
            //"courseId": courseId

        ]
    }

    
    
}