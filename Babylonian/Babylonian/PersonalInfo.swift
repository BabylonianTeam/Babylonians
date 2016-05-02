//
//  PersonalInfo.swift
//  Babylonian
//
//  Created by Sheng Gan on 4/3/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation
import Firebase

class PersonalInfo: NSObject{
    var displayName_: String!
    var email_: String!
    var profilePhoto_: String!
    var balance_: Float!
   // var ownedCourses_ = [OwnedCourseItem]()
    var ref_: Firebase!
    
    var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    
    init(id: String?){
        if (id != nil){
            self.ref_ = _USER_REF.childByAppendingPath(id)
        }
    }
    
    func setRef(id: String?){
        if (id != nil){
            self.ref_ = _USER_REF.childByAppendingPath(id)
        }
    }
    
    func updateDisplayName(displayName: String) -> Void {
        self.displayName_ = displayName
        self.ref_.updateChildValues([USER_DISPLAYNAME:displayName])
    }
    
    func updateEmail(email: String) -> Void {
        self.email_ = email
        self.ref_.updateChildValues([USER_EMAIL:email])
    }
    
    func updateProfilePhoto(url: String) -> Void {
        self.profilePhoto_ = url
        self.ref_.updateChildValues([USER_PROFILEPHOTO:url])
    }
    
    func updateBalance(balance: Float) -> Void {
        self.balance_ = balance
        self.ref_.updateChildValues([USER_BALANCE: balance])
    }
    
    //get purchased date
    func getCurrentDate() -> String{
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        let year =  components.year
        let month = components.month
        let day = components.day
        let currDate = String(month) + "-" + String(day) + "-" + String(year);
        return currDate
    }
    
    //TODO: add userRole class?  role.ownedCourse = USER_PURCHASED_COURSE
    /*
    func ownedCourse(purchasedCourseId: String) -> Void{
        let currDate = getCurrentDate()
        
        let newCourse_ref = self.ref_.childByAppendingPath(USER_PURCHASED_COURSE).childByAppendingPath(purchasedCourseId)
        
        
        newCourse_ref.setValue([USER_PURCHASED_COURSE_DATE: currDate])
        self.ownedCourses_.append(OwnedCourseItem(ref: newCourse_ref, ownedDate: currDate))
    }
    
    //get purchased courses count
    func getOwnedCoursesCount() -> Int{
        return self.ownedCourses_.count
    }
    */
    
    /*
    //function when do purchase
    func addPurchasedCourse(purchasedCourseId: String) -> Void {
        let currDate = getCurrentDate()
        let newCourse_ref = self.ref_.childByAppendingPath(USER_PURCHASED_COURSE).childByAppendingPath(purchasedCourseId)
        newCourse_ref.setValue([USER_PURCHASED_COURSE_DATE: currDate])
        self.ownedCourses_.append(OwnedCourseItem(ref: newCourse_ref, ownedDate: currDate))
        
    }

    func addCreatedCourse(createdCourseId: String) -> Void{
        let currDate = getCurrentDate()
        let newCourse_ref = self.ref_.childByAppendingPath(USER_CREATED_COURSE).childByAppendingPath(createdCourseId)
        newCourse_ref.setValue([USER_CREATED_COURSE_DATE: currDate])
        self.ownedCourses_.append(OwnedCourseItem(ref: newCourse_ref, ownedDate: currDate))
    }
    */
    
}