//
//  Minicourse.swift
//  Babylonian
//
//  Created by Jiqing Xu on 3/14/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase
import AVKit



class Minicourse{
    static var currentText = [String]()
    static var minicourse = Minicourse()
    static var BOOL = false
    static var Text = [String]()
    static var base64String: NSString!
    static var base64StringAudio: NSString!
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _COURSE_REF = Firebase(url: "\(BASE_URL)/courses")
    
  private static var currentMinicourse: BBCourse?
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var COURSE_REF: Firebase {
        return _COURSE_REF
    }
    
    
    class func setPrice(ref: String!, price: Double!){
        
        let pricewrapper = ["price": price]
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)?.updateChildValues(pricewrapper)
   
    }
   
    class func setAuthorName(ref: String!, name: String!){
       
        let namewrapper = ["COURSE_AUTHOR": name]
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)?.updateChildValues(namewrapper)
        
    }
   
    class func setTag(ref: String!, tag: String!){
        
        let tagwrapper = ["tag": tag]
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)?.updateChildValues(tagwrapper)
        
    }
    
    class func addBBCourse(BBCourse: AnyObject!) {
        
       let firebaseNewCourse =  Minicourse.minicourse.COURSE_REF.childByAutoId()
       firebaseNewCourse.setValue(BBCourse)
        
    }
    
    class func changeCourseName(courseRef: String!, newCourseName: String!){
    
    Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef)?.childByAppendingPath("COURSE_TITLE").setValue(newCourseName)
    
    }
    
    class func addCourseItem(courseRef: String!, newCourseItem: NSObject!){
        
    Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef)?.childByAppendingPath("content").childByAutoId().setValue(newCourseItem)
        
    }
    
    class func delectCourseItem(refForDelect: String!,courseRef: String!){
        
    Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef).childByAppendingPath("content").childByAppendingPath(refForDelect).removeValue()
        
    }
    
    class func deleteMinicourseItem(ref: String!){
        
    let removeCourseItem = Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)
        removeCourseItem.removeValue()
       
        
    }
    
    class func updateText(courseRef: String!, courseItemRef: String!, newText: String){
    
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef).childByAppendingPath("content").childByAppendingPath(courseItemRef).childByAppendingPath("courseText").setValue(newText)

    }
    
    class func updateAudio(courseRef: String!, courseItemRef: String!, newAudio: String){
        
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef).childByAppendingPath("content").childByAppendingPath(courseItemRef).childByAppendingPath("courseAudio").setValue(newAudio)
        
    }
    
    class func updateImage(courseRef: String!, courseItemRef: String!, newImage: String){
        
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef).childByAppendingPath("content").childByAppendingPath(courseItemRef).childByAppendingPath("courseImage").setValue(newImage)
        
    }
    
    class func updateOrder(courseRef: String!, courseItemRef: String!, newOrder: Int){
        
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef).childByAppendingPath("content").childByAppendingPath(courseItemRef).childByAppendingPath("order").setValue(newOrder)
        
    }

}


