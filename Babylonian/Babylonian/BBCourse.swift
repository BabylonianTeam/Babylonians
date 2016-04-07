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
    
    var title_: String?
    var author_: String!
    var courseItems_: [CourseItem]!
    var ref_: Firebase!
    var price_: Float!
    var tag_: [String]!
    
    var purchased_counter_: Int!

    init(ref: Firebase, author: String) {
        // to create a course
        self.ref_ = ref
        self.author_ = author
        self.ref_.updateChildValues([COURSE_AUTHOR:author])
        self.courseItems_ = [CourseItem]()
        self.tag_ = [String]()
    }
    
    init(ref: Firebase) {
        //to read a course
        self.ref_ = ref
        self.courseItems_ = [CourseItem]()
        self.tag_ = [String]()
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
    
    func setAuthor(author: String) -> Void {
        self.author_ = author
        self.courseRef.updateChildValues([COURSE_AUTHOR:author])
    }
    
    //may need depreciate
    func addNewCourseItem() -> Void {
        let item_ref = self.ref_.childByAppendingPath(COURSE_CONTENT).childByAutoId()
        item_ref.setValue([COURSE_ITEM_ORDER:self.contents.count+1])
        self.courseItems_.append(CourseItem(ref: item_ref, order: self.contents.count+1))
    }
    
    func addNewATItem(courseText: String, courseAudio: String, duration: Float) -> Void {
        let item_ref = self.ref_.childByAppendingPath(COURSE_CONTENT).childByAutoId()
        item_ref.setValue([COURSE_ITEM_ORDER:self.contents.count+1,
            COURSE_ITEM_TEXT:courseText,
            COURSE_ITEM_AUDIO:courseAudio,
            COURSE_ITEM_AUDIO_DURATION:duration])
        self.courseItems_.append(ATItem(ref: item_ref, courseText: courseText, courseAudio: courseAudio, order: self.contents.count+1, duration:duration))
    }
    func addNewImageItem(courseImage: String) -> Void {
        let item_ref = self.ref_.childByAppendingPath(COURSE_CONTENT).childByAutoId()
        item_ref.setValue([COURSE_ITEM_ORDER:self.contents.count+1,
                        COURSE_ITEM_IMAGE:courseImage])
        self.courseItems_.append(ImageItem(ref: item_ref, courseImage:courseImage, order: self.contents.count+1))
    }
    
    func setTag(tag: String, tagArray: [String]) -> Void {
        self.tag_ = tagArray
        self.courseRef.setValue([COURSE_TAG:tag])
    }
    
    func deleteAllTag() -> Void {
        self.tag_.removeAll()
        self.courseRef.updateChildValues([COURSE_TAG: ""])
    }
    
    func updateCourseItem(item:CourseItem) -> Bool {
        if item.courseRef==self.courseRef {
            item.itemRef.updateChildValues(item.toAnyObject() as! [NSObject : AnyObject])
            
            return true
        }
        else {
            print("Cannot delete item in another course")
            return false
        }
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
        var i = 0
        for item in contents {
            if item.order>ord {
                item.order = item.order-1
                item.itemRef.childByAppendingPath(COURSE_ITEM_ORDER).setValue(item.order)
            }
            else if item.order==ord {
                self.courseItems_.removeAtIndex(i)
                item.itemRef.removeValue()
                success = true
            }
            i = i+1
        }
        return success
    }
    
    //this is a dangerous function. If course is deleted remotely, while this instance is not destroyed, most operations in this class will lead to error
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
            item.itemRef.setValue(item.order, forKeyPath: COURSE_ITEM_ORDER)
            i = i+1
        }
    }
    
    func reloadCourseFromRef() -> Void {
        self.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            if let course = snapshot.value {
                for (key, value) in course as! [String:AnyObject]{
                    
                    switch key {
                    case COURSE_CONTENT:
                        for item in value as! [String:NSDictionary]{
                            let item_ref = self.contentRef.childByAppendingPath(item.0)
                            if let im_ref = item.1[COURSE_ITEM_IMAGE] {
                                
                                let courseItem = ImageItem(ref: item_ref, courseImage: im_ref as! String,order: item.1[COURSE_ITEM_ORDER] as! Int)
                                self.addCourseItem(courseItem)
                                
                            }
                            else if let text_ref = item.1[COURSE_ITEM_TEXT]  {
                                let courseItem = ATItem(ref: item_ref,courseText: text_ref as! String, courseAudio: item.1[COURSE_ITEM_AUDIO] as! String, order: item.1[COURSE_ITEM_ORDER] as! Int, duration: item.1[COURSE_ITEM_AUDIO_DURATION] as! Float)
                                self.addCourseItem(courseItem)
                            }
                        }
                    case COURSE_AUTHOR:
                        self.author_ = value as! String
                    case COURSE_TITLE:
                        self.title_ = value as? String
                    case COURSE_PRICE:
                        self.price_ = value as! Float
                    case COURSE_TAG:
                        self.tag_ = value as! [String]
                    case COURSE_NUM_SOLD:
                        self.purchased_counter_ = value as! Int
                    default:
                        print("forgoten key: "+key)
                    }
                }
                
                self.sortContentsByOrder()
            }
        })
    }
    
    func reloadContentsFromRef() {
        self.contentRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            if let content = snapshot.value {
                for item in content as! [String:NSDictionary]{
                    let item_ref = self.contentRef.childByAppendingPath(item.0)
                    if let im_ref = item.1[COURSE_ITEM_IMAGE] {
                        
                        let courseItem = ImageItem(ref: item_ref, courseImage: im_ref as! String,order: item.1[COURSE_ITEM_ORDER] as! Int)
                        self.addCourseItem(courseItem)
                        
                    }
                    else if let text_ref = item.1[COURSE_ITEM_TEXT]  {
                        let courseItem = ATItem(ref: item_ref,courseText: text_ref as! String, courseAudio: item.1[COURSE_ITEM_AUDIO] as! String, order: item.1[COURSE_ITEM_ORDER] as! Int, duration: item.1[COURSE_ITEM_AUDIO_DURATION] as! Float)
                        self.addCourseItem(courseItem)
                    }
                }
                self.sortContentsByOrder()
            }
        })
    }
    
    func moveItemTo(from:Int, to:Int) -> Void{
        if from == to {
            return
        }
        else if from>to {
            for item in contents {
                if item.order==from {
                    item.order = to
                    
                    item.itemRef.updateChildValues([COURSE_ITEM_ORDER:item.order])
                }
                else if item.order<from && item.order>=to{
                    item.order = item.order+1
                    item.itemRef.updateChildValues([COURSE_ITEM_ORDER:item.order])
                }
            }
        }
        else {
            for item in contents {
                if item.order==from {
                    item.order = to
                    item.itemRef.updateChildValues([COURSE_ITEM_ORDER:item.order])
                }
                else if item.order>from && item.order<=to {
                    item.order = item.order-1
                    item.itemRef.updateChildValues([COURSE_ITEM_ORDER:item.order])
                }
            }
        }
    }
    
    
  

    var author: String {
        return self.author_
    }
    var title: String? {
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

