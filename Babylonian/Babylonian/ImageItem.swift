//
//  ImageItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase

class ImageItem: CourseItem {
    
    init(ref: Firebase, courseImage: String, order: Int) {//, courseText: NSObject
        super.init(ref: ref, order:order)
        self.content=[COURSE_ITEM_IMAGE:courseImage]
    }
    
    override func getType() -> String {
        return COURSE_ITEM_TYPE_IMAGE
    }
    
    override func toAnyObject() -> AnyObject {
        
        return [
            COURSE_ITEM_IMAGE: self.content[COURSE_ITEM_IMAGE] as! String,
            COURSE_ITEM_ORDER: order
            //"courseId": courseId
        ]
    }

}