//
//  CourseItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation


class CourseItem {
    var order: Int!
    var courseId: String!
    
    func getType() -> String {
        //this function need to be overriden
        fatalError("Must Override")
    }
}