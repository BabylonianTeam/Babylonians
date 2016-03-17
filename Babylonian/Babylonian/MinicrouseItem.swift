//
//  MinicrouseItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 3/15/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//


import Foundation
import Firebase


struct MinicourseItem {
     //static var minicourseItem = MinicourseItem()
   // var coursekey: String!
    var coursename: String!
    var addedByUser: String!
    var ref: Firebase!
    var courseText: NSObject!
   // var price: Double!
   // var tag: [String]!

    
    // Initialize from arbitrary data
    init(coursename: String, addedByUser: String, courseText: NSObject) {
       // self.coursekey = coursekey
        self.coursename = coursename
        self.addedByUser = addedByUser
        self.courseText = courseText
       // self.price = price
       // self.tag = tag
        self.ref = Minicourse.minicourse.COURSE_REF.childByAppendingPath("refUrl")
    }
    
    init(snapshot: FDataSnapshot) {
       // coursekey = snapshot.key
        coursename = snapshot.value["coursename"] as! String
        addedByUser = snapshot.value["addedByUser"] as! String
        courseText = snapshot.value["courseText"] as! NSObject
      //  price = snapshot.value["price"] as! Double
      //  tag = snapshot.value["tag"] as! [String]
        ref = snapshot.ref
    
    }
    
    
//    func toAnyObject() -> AnyObject {
//        return [
//            "coursename": coursename,
//            "addedByUser": addedByUser,
//            "courseText": courseText
//        
//        ]
//    }
    
    
    func toAnyObject() -> AnyObject {
        
    return [
        
        "coursename": coursename,
        "addedByUser": addedByUser,
        "courseText": courseText
       // "addedByUser": addedByUser,
       // "courseText": courseText
        
        
        ]
}
}

//   func getMinicourseItem(Index: Int) //->MinicourseItem
//    {
//        
//        Minicourse.minicourse.COURSE_REF.observeEventType(.Value, withBlock: { snapshot in
//            
//            var newItems = [MinicourseItem]()
//            
//            // print(snapshot.children)
//            
//            for item in snapshot.children {
//                let minicourseItem = MinicourseItem(snapshot: item as! FDataSnapshot)
//                newItems.append(minicourseItem)
//                //print(newItems)
//                
//            }
//            
//            
//            self.minicourse = newItems[Index]
//            print(self.minicourse)
//            
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
//        
//        //sleep(10)
//        print("start")
//        print(self.minicourse)
//        //  return self.currentMinicourse
//        
//    }
//
    

