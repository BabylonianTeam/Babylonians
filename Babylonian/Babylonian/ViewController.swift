//
//  ViewController.swift
//  Babylonian
//
//  Created by Eric Smith on 3/6/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class ViewController: UIViewController {
    
 var miniCourseitems = [MinicourseItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
                
        
        
   //     let newText = MinicourseTextItem(courseText: ["2333333333", "Nice to meet you"])
        
//               let newCourse = MinicourseItem(
//                    coursename:"test course4", addedByUser: "test user4", courseText : ["hi", "Nice to meet you"]
//        )
//        
//        
//        
//                Minicourse.addMinicourseItem(newCourse.toAnyObject())

      //  Minicourse.setPrice("refUrl",price: 6.6)
//        Minicourse.setTag("refUrl", tag: "travel")
//        Minicourse.setAuthorName("refUrl", name: "I am the new name")
//        Minicourse.changeCourseName("refUrl", newCourseName: "This is the new course name")
       // Minicourse.addText("refUrl", newText: "11111111111111111111111")
       
        //Minicourse.delectText("0", courseRef: "refUrl")
        
        
      
    
   //Minicourse.deleteMinicourseItem("555555")
     //   let currentCourse = 
       
       // Minicourse.getUser()
        
       
        //* This is the add text for existing minicourse for specific index
        
       // var newcurrentRef: Firebase?
        
   //   Minicourse.minicourse.COURSE_REF.observeEventType(.Value, withBlock: { snapshot in
            
            //            let currentUser = snapshot.value.objectForKey("addedByUser") as! String
            //
            //            print("addedByUser: \(currentUser)")
            //            self.currentUsername  = currentUser
            
            // print(snapshot.value.objectForKey("refUrl")?.objectForKey("courseText"))
            
//            let newCourse = MinicourseItem(
//                        coursename:"test course1", addedByUser: "test user1", courseText:["2333333333", "Nice to meet you"]
//            
//                    )
//            
//                    Minicourse.addMinicourseItem(newCourse.toAnyObject())
            
      

            
            
            
            
//            let Index = 0
//            var newItems = [MinicourseItem]()
          //  let NewText = ["testing add"]
                    //   print(snapshot.children)
            
//                    for item in snapshot.children {
//                        let minicourseItem = MinicourseItem(snapshot: item as! FDataSnapshot)
//                        newItems.append(minicourseItem)
//                        print(newItems)
//                        
//                    }

          //  let newcurrentText = snapshot.value.objectForKey("refUrl")?.objectForKey("courseText") as! [String]
        
        
           //let newText = ["new": NewText]
        
//        let currentMinicourse = newItems[Index]
//         newcurrentRef = currentMinicourse.ref?.childByAppendingPath("courseText").childByAutoId()
            //.setValue("newText!!")
        
     
        

        
          // let newText = [3: NewText]
        //currentMinicourse.ref?.childByAppendingPath("courseText").setValue("I am new added courseText")
            
            
           // let newcurrentText = snapshot.value.objectForKey("refUrl")?.objectForKey("courseText") as! [String]
            
            //        let newText = snapshot.value.objectForKey("refUrl")?.objectForKey("courseText") as! String
          //  currentText = newcurrentText
            
             //  print(currentText)
            
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
//        
//        
//       newcurrentRef?.setValue("666666666666666666")
        
        
//        func addText(courseItem: MinicourseItem, newText: String){
//            
//            let newText = ["courseText": newText]
//            courseItem.ref?.updateChildValues(newText)
//            
//            
//        }
        
        
        
        
        
        
  //      print(Minicourse.currentText)
      //  print(Minicourse.Text)
       // Minicourse.getMinicourseItem(0)
        
     //   var currentMinicourse = MinicourseItem()
      //  print(Minicourse.currentMinicourse)
    //    Minicourse.addText(currentCourse, newText: "New String")
        
        
//        
//        let newCourse = MinicourseItem(
//            coursename:"test course4", addedByUser: "test user4", courseText:["2333333333", "Nice to meet you"]
//            
//        )
//       
//        Minicourse.addMinicourseItem(newCourse.toAnyObject())

        
//        Minicourse.minicourse.COURSE_REF.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
        
        
        
        // newCourse.ref?.removeValue()
      
//        Minicourse.minicourse.COURSE_REF.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//           
//            
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
        
        
        
        
//        
//         Minicourse.minicourse.COURSE_REF.observeEventType(.Value, withBlock: { snapshot in
//           
//            var newItems = [MinicourseItem]()
//
//            for item in snapshot.children {
//            let minicourseItem = MinicourseItem(snapshot: item as! FDataSnapshot)
//                newItems.append(minicourseItem)
//                //print(minicourseItem)
//            }
////           print(newItems[0])
////           print(newItems[0].ref)
////            print(newItems[1])
////            print(newItems[1].ref)
//            
//            
//            newItems[0].ref!.removeValue()
//        })
        
        
       
        
//        
//        SampleDataGenerator.sampleDataGenerator.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
//            
//           let currentUser = snapshot.value.objectForKey("username") as! String
//            
//            print("Username: \( snapshot.value.objectForKey("username") as! String)")
//            SampleDataGenerator.currentUsername = currentUser
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
    

    
        
        // Do any additional setup after loading the view, typically from a nib.
//        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && SampleDataGenerator.sampleDataGenerator.CURRENT_USER_REF.authData != nil {
//            self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
//            
//    }
                  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

