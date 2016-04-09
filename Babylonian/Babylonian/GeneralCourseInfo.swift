//
//  GeneralCourseList.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/8/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase

class GeneralCourseInfo: NSObject {
    var title: String!
    var ref: Firebase!
    var NoV: Int = 0

    init(ref: Firebase, title: String) {
        self.ref = ref
        self.title = title
    }
}