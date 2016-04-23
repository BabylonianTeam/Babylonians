//
//  CreatorInfo.swift
//  Babylonian
//
//  Created by Sheng Gan on 4/16/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation
import Firebase

class CreatorInfo: NSObject{
    var createdCourses_ = [OwnedCourseItem]()
    //var purchasedCoursesCount: Int!
    
    var ref_: Firebase!
    var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    
    var creator: PersonalInfo!
    
    init(id: String?){
        if (id != nil){
            self.ref_ = _USER_REF.childByAppendingPath(id)
        }
    }
    
    
    func addCreatedCourse(createdCourseId: String) -> Void{
        let currDate = creator.getCurrentDate()
        let newCourse_ref = self.ref_.childByAppendingPath(USER_CREATED_COURSE).childByAppendingPath(createdCourseId)
        newCourse_ref.setValue([USER_CREATED_COURSE_DATE: currDate])
        self.createdCourses_.append(OwnedCourseItem(ref: newCourse_ref, ownedDate: currDate))
        //self.purchasedCoursesCount = self.purchasedCoursesCount + 1
    }
    
    func getCreatedCoursesCount() -> Int{
        return self.createdCourses_.count
    }
    
    
    /*
    func addCreatedCourse(createdCourseId: String){
        //super.ownedCourse(createdCourseId)
    }
    */
}