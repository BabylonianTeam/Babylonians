//
//  ViewController.swift
//  Babylonian
//
//  Created by Eric Smith on 3/6/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
   //Minicourse.deleteMinicourseItem("555555")
     //   let currentCourse = 
       
        Minicourse.getUser()
        print(Minicourse.currentText)

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

