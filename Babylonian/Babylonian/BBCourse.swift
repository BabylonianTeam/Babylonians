//
//  MinicrouseItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 3/15/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//


import Foundation
import Firebase


class BBCourse: NSObject {
    
    var title_: String!
    var author_: String!
    var courseItems_: [CourseItem]!
    var ref_: Firebase!
    var price_: Float!
    var tag_: [String]!
    

    init(ref: Firebase, author: String) {
        self.ref_ = ref
        self.author_ = author
        self.ref_.updateChildValues([COURSE_AUTHOR:author])
    }
    
    
    func setTitle(title: String) -> Void {
        self.title_ = title
        self.firebaseRef.updateChildValues([COURSE_TITLE:title])
    }
    
    func setPrice(price: Float) -> Void {
        self.price_ = price
        self.firebaseRef.updateChildValues([COURSE_PRICE:price])
    }
    
    
    func setAuthorName(author: String) -> Void {
        self.author_ = author
        self.firebaseRef.updateChildValues([COURSE_AUTHOR:author])
    }
    
    func setTag(tag: [String]) -> Void {
        self.tag_ = tag
        self.firebaseRef.updateChildValues([COURSE_TAG:tag])
    }
    
    
    func deleteBBCourse() -> Void{
        
        self.firebaseRef.removeValue()
    }
    
    var author: String {
        return self.author_
    }
    var title: String {
        return self.title_
    }
    var firebaseRef: Firebase {
        return ref_
    }
    var contents: [CourseItem] {
        return courseItems_
    }
    
    var tag: [String] {
        return tag_
    }
    
    var price: Float {
        return price_
    }
    
    func toAnyObject() -> AnyObject {
        
        return [
            COURSE_TITLE: self.title_,
            COURSE_AUTHOR: self.author_
       
            ]
    }
}

