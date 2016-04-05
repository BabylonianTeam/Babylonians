//
//  MinicrouseItem.swift
//  Babylonian
//
//  Modified by Dongning Wang
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
        self.courseItems_ = [CourseItem]()
    }
    
    
    func setTitle(title: String) -> Void {
        self.title_ = title
        self.courseRef.updateChildValues([COURSE_TITLE:title])
    }
    
    func setPrice(price: Float) -> Void {
        self.price_ = price
        self.courseRef.updateChildValues([COURSE_PRICE:price])
    }
    
    func addCourseItem(item:CourseItem) -> Void {
        self.courseItems_.append(item)
    }
    
    func setAuthorName(author: String) -> Void {
        self.author_ = author
        self.courseRef.updateChildValues([COURSE_AUTHOR:author])
    }
    
    func addNewCourseItem() -> Void {
        let item_ref = self.ref_.childByAppendingPath(COURSE_CONTENT).childByAutoId()
        item_ref.setValue([COURSE_ITEM_ORDER:self.contents.count+1])
        self.courseItems_.append(CourseItem(ref: item_ref, order: self.contents.count+1))
    }
    func addNewATItem(courseText: String, courseAudio: String) -> Void {
        let item_ref = self.ref_.childByAppendingPath(COURSE_CONTENT).childByAutoId()
        item_ref.setValue([COURSE_ITEM_ORDER:self.contents.count+1,
            COURSE_ITEM_TEXT:courseText,
            COURSE_ITEM_AUDIO:courseAudio])
        self.courseItems_.append(ATItem(ref: item_ref, courseText: courseText, courseAudio: courseAudio, order: self.contents.count+1))
    }
    func addNewImageItem(courseImage: String) -> Void {
        let item_ref = self.ref_.childByAppendingPath(COURSE_CONTENT).childByAutoId()
        item_ref.setValue([COURSE_ITEM_ORDER:self.contents.count+1,
                        COURSE_ITEM_IMAGE:courseImage])
        self.courseItems_.append(ImageItem(ref: item_ref, courseImage:courseImage, order: self.contents.count+1))
    }
    
    func setTag(tag: [String]) -> Void {
        self.tag_ = tag
        self.courseRef.updateChildValues([COURSE_TAG:tag])
    }
    
    func deleteCourseItem(item:CourseItem) -> Bool{
        if item.courseRef==self.courseRef {
            let order = item.order
            item.itemRef.removeValue()

            for itm in contents {
                if itm.order>order {
                    itm.order = itm.order-1
                }
            }
            return true
        }
        else {
            print("Cannot delete item in another course")
            return false
        }
    }
    
    func deleteCourseItem(ord: Int!) -> Bool {
        var success = false
        for item in contents {
            if item.order>ord {
                item.order = item.order-1
            }
            else if item.order==ord {
                item.itemRef.removeValue()
                success = true
            }
        }
        return success
    }
    
    func deleteBBCourse() -> Void{
        self.courseRef.removeValue()
    }

    func sortContentsByOrder() -> Void{
        self.courseItems_ = self.contents.sort({$0.order<$1.order})
    }
    
    func setItemOrdersAsInContents() -> Void {
        var i = 0
        for item in courseItems_ {
            item.order = i
            i = i+1
        }
    }
    
    func moveItemTo(from:Int, to:Int) -> Void{
        if from == to {
            return
        }
        else if from>to {
            for item in contents {
                if item.order==from {
                    item.order = to
                }
                else if item.order<from && item.order>=to{
                    item.order = item.order+1
                }
            }
        }
        else {
            for item in contents {
                if item.order==from {
                    item.order = to
                }
                else if item.order>from && item.order<=to {
                    item.order = item.order-1
                }
            }
        }
    }
    
    var author: String {
        return self.author_
    }
    var title: String {
        return self.title_
    }
    var courseRef: Firebase {
        return ref_
    }
    var contentRef: Firebase {
        return self.ref_.childByAppendingPath(COURSE_CONTENT)
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

