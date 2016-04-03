//
//  ImageItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation

class ImageItem: CourseItem {
    
    var courseImage: String!
    
    init(courseImage: String, order: Int) {//, courseText: NSObject
        super.init()
        self.courseImage = courseImage
        self.order = order
        self.courseId = courseId
     
    }
    
    var id : String{
        return self.courseId
    }
    
    override func getType() -> String {
        return COURSE_ITEM_TYPE_IMAGE
    }
    
    func toAnyObject() -> AnyObject {
        
        return [
            
            COURSE_ITEM_IMAGE: courseImage,
            COURSE_ITEM_ORDER: order,
            //"courseId": courseId
            
            
            
        ]
    }

}