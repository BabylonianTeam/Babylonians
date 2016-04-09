//
//  MyCourseInfo.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/9/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase

class MyCourseInfo: NSObject {
    var title: String!
    var ref: Firebase!
    var income: Float = 0
    var NoV: Int = 0
    
    init(ref: Firebase, title: String) {
        self.ref = ref
        self.title = title
    }
}