//
//  MinicourseTextItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 3/16/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase


struct MinicourseTextItem {

var newcourseText: [String]!

    init(courseText: [String]) {
        
        self.newcourseText = courseText
               
    }
    
    
    func toAnyObject() -> AnyObject? {
        return [
            
            "courseText": newcourseText
            
        ]
    }

}