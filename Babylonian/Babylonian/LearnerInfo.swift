//
//  LearnerInfo.swift
//  Babylonian
//
//  Created by Sheng Gan on 4/16/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation
import Firebase

class LearnerInfo: NSObject{
    var purchasedCourses_ = [OwnedCourseItem]()
    var ref_: Firebase!
    var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    
    var learner: PersonalInfo!
    
    init(id: String?){
        if (id != nil){
            self.ref_ = _USER_REF.childByAppendingPath(id)
        }
    }
    
    func addPurchasedCourse(purchasedCourseId: String) -> Void {
        let currDate = learner.getCurrentDate()
        let newCourse_ref = self.ref_.childByAppendingPath(USER_PURCHASED_COURSE).childByAppendingPath(purchasedCourseId)
        newCourse_ref.setValue([USER_PURCHASED_COURSE_DATE: currDate])
        self.purchasedCourses_.append(OwnedCourseItem(ref: newCourse_ref, ownedDate: currDate))
    }
    
    func getPurchasedCoursesCount() -> Int{
        return self.purchasedCourses_.count
    }
    
    /*
    func addPurchasedCourse(purchasedCourseId: String){
        super.ownedCourse(purchasedCourseId)
    }
    */
    
}

