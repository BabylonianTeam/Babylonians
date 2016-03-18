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
    
  private static var currentMinicourse: MinicourseItem?
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
//    
//    var CURRENT_COURSE_REF: Firebase {
//        
//        
//        let currentCourse = Firebase(url: "\(BASE_REF)").childByAppendingPath("5555555")
//        return currentCourse!
//    }
//    
    
    
    var COURSE_REF: Firebase {
        return _COURSE_REF
    }
    
    
    class func setPrice(ref: String!, price: Double!){
        let pricewrapper = ["price": price]
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)?.updateChildValues(pricewrapper)

    }
   
    class func setAuthorName(ref: String!, name: String!){
        let namewrapper = ["addedByUser": name]
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)?.updateChildValues(namewrapper)
        
    }
   
    class func setTag(ref: String!, tag: String!){
        let tagwrapper = ["tag": tag]
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)?.updateChildValues(tagwrapper)
        
    }
    
    class func addMinicourseItem(MinicourseItem: AnyObject!) {
    
        
     let firebaseNewCourse =  Minicourse.minicourse.COURSE_REF.childByAutoId()
        //let refUrl = MinicourseItem.ref.description
     // let firebaseNewCourse =  Minicourse.minicourse.COURSE_REF.childByAppendingPath("refUrl")
        
        firebaseNewCourse.setValue(MinicourseItem)
    }
    
    class func changeCourseName(courseRef: String!, newCourseName: String!){
    
    Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef)?.childByAppendingPath("coursename").setValue(newCourseName)
    
    }
    
    class func addText(ref: String!, newText: String!){
        
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)?.childByAppendingPath("courseText").childByAutoId().setValue(newText)
        
    }
    
    class func delectText(refForDelectText: String!,courseRef: String!){
        
         Minicourse.minicourse.COURSE_REF.childByAppendingPath(courseRef).childByAppendingPath("courseText").childByAppendingPath(refForDelectText).removeValue()

        
    }
    
    class func addImage(newImage: UIImage, ref: String!) {
        var imageData: NSData? = UIImagePNGRepresentation(newImage)
        self.base64String = imageData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
       // var quoteString = ["string": self.base64String]

        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref).childByAppendingPath("images").childByAutoId().setValue(self.base64String)
    }

    class func deleteImage(imageRef: String, ref: String) {
    
         Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref).childByAppendingPath("images").childByAppendingPath(imageRef).removeValue()
        
    }
    
    /*
    
    class func addVocie(newVoice: NSSound, ref: String!){
        var sound: NSData = NSSound.
        self.base64StringAudio = newVoice.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref).childByAppendingPath("voice").childByAutoId().setValue(self.base64StringAudio)

        
        
    }
    
    class func deleteVocie(voiceRef: String, ref: String){
        
        
        
        Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref).childByAppendingPath("voice").childByAppendingPath(ref).removeValue()
        
        
    }
   */
    
    class func deleteMinicourseItem(ref: String!){
        
            
            let removeCourseItem = Minicourse.minicourse.COURSE_REF.childByAppendingPath(ref)
            removeCourseItem.removeValue()
       
        
    }
    
    
    
    class func getMinicourseItem(Index: Int) //->MinicourseItem
    {
        
//        Minicourse.minicourse.COURSE_REF.observeEventType(.Value, withBlock: { snapshot in
//      
//          var newItems = [MinicourseItem]()
//            
//          // print(snapshot.children)
//        
//        for item in snapshot.children {
//            let minicourseItem = MinicourseItem(snapshot: item as! FDataSnapshot)
//            newItems.append(minicourseItem)
//            //print(newItems)
//            
//        }
//            
//            
//          self.currentMinicourse = newItems[Index]
//           print(self.currentMinicourse)
//            self.BOOL = true;
//            
//            }, withCancelBlock: { error in
//                print(error.description)
//                
//        })
//        while(!BOOL){
//                print("aa!")
//        }
        //sleep(10)
//
//     print(self.minicourse)
      //  return self.currentMinicourse
        
//        Minicourse.minicourse.COURSE_REF.queryEqualToValue("courseName").observeEventType(.Value, withBlock: { snapshot in
//        if let courseName = snapshot.value["courseName"] as? String {
//         print("\(snapshot.key) was \(courseName) !!!!")
//            }
//        
//        
//        })
        
        
        
        
        
    }
    
    
    
   class func getUser(){
    
    Minicourse.minicourse.COURSE_REF.queryOrderedByValue().observeEventType(.Value, withBlock: { snapshot in
            
//            let currentUser = snapshot.value.objectForKey("addedByUser") as! String
//            
//            print("addedByUser: \(currentUser)")
//            self.currentUsername  = currentUser
        
           // print(snapshot.value.objectForKey("refUrl")?.objectForKey("courseText"))
        
        let newcurrentText = snapshot.value.objectForKey("refUrl")?.objectForKey("courseText") as! [String]
        
//        let newText = snapshot.value.objectForKey("refUrl")?.objectForKey("courseText") as! String
        self.currentText = newcurrentText
        
   //     print(self.currentText)
        //print(self.currentText)
        }, withCancelBlock: { error in
                print(error.description)
        })
    
    
    
    }
    

    
    func addText(courseItem: MinicourseItem, newText: String){
        
          let newText = ["courseText": newText]
          courseItem.ref?.updateChildValues(newText)
        
        
    }
    //    Add to the text of a sentence.
    

    
    //    void deleteText()
//    Delete the text of a sentence.
//    void editText()
//    Edit the text of a sentence.

    
    
    
}


