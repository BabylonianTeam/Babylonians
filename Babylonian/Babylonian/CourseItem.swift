//
//  CourseItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase


class CourseItem: NSObject {
    var order: Int!
    var content: NSMutableDictionary!
    var ref_: Firebase!
            
    init(ref:Firebase!, order: Int) {
        content = NSMutableDictionary()
        self.ref_ = ref
        self.order = order
    }
    
    var itemRef: Firebase {
        return self.ref_
    }
    
    var courseRef: Firebase {
        return self.ref_.parent
    }
    
    func getType() -> String {
        //this function need to be overriden
        fatalError("Must Override")
    }
    
    func toAnyObject() -> AnyObject {
        //this function need to be overriden
        fatalError("Must Override")
    }
}