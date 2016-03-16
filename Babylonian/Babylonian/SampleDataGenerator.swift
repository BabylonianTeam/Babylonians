//
//  SampleDataGenerator.swift
//  Babylonian
//
//  Created by Ben Freeman on 3/6/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase

//class SampleDataGenerator{
//    static var currentUsername = ""
//    
//    static let sampleDataGenerator = SampleDataGenerator()
//    
//    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
//    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
//    private var _COURSE_REF = Firebase(url: "\(BASE_URL)/courses")
//    
//    
//    var BASE_REF: Firebase {
//        return _BASE_REF
//    }
//    
//    var USER_REF: Firebase {
//        return _USER_REF
//    }
//    var CURRENT_USER_REF: Firebase {
//        
//       let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
//        
//        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
//        
//        return currentUser!
//    }
//    
//    var COURSE_REF: Firebase {
//        return _COURSE_REF
//    }
//    
//    
//    func createNewAccount(uid: String, user: Dictionary<String, String>) {
//        
//        // A User is born.
//        
//        USER_REF.childByAppendingPath(uid).setValue(user)
//    }
//    
//    
//    
//    
//    
//    
//    func createNewCourse(Courses: Dictionary<String, AnyObject>) {

        // Save the Joke
        // JOKE_REF is the parent of the new Joke: "jokes".
        // childByAutoId() saves the joke and gives it its own ID.
        
//        let firebaseNewCourse =  SampleDataGenerator.sampleDataGenerator.COURSE_REF.childByAutoId()
//        
//        // setValue() saves to Firebase.
//        
//        firebaseNewCourse.setValue(Courses)
//    }

    
   // func saveCourse(courseText:String) {
        
        //  let jokeText = jokeField.text
        
      //  if courseText != "" {
            
            // Build the new Joke.
            // AnyObject is needed because of the votes of type Int.
//            
//            let newCourse: Dictionary<String, AnyObject> = [
//                "courseText": courseText,
//                "votes": 0,
//                "author":  SampleDataGenerator.currentUsername
//            ]

            // Send it over to DataService to seal the deal.
            
       //     SampleDataGenerator.sampleDataGenerator.createNewCourse(newCourse)
            
//            if let navController = self.navigationController {
//                navController.popViewControllerAnimated(true)
//            }
    //    }
        
        
        
        
   // }

    
    
    
//}


//func createAccount(username: String, email: String, password: String) {
//    if username != "" && email != "" && password != "" {
//        
//        // Set Email and Password for the New User.
//        
//        SampleDataGenerator.sampleDataGenerator.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
//            
//            if error != nil {
//                
//              print("error")
//                
//                
//            } else {
//                
//                // Create and Login the New User with authUser
//               SampleDataGenerator.sampleDataGenerator.BASE_REF.authUser(email, password: password, withCompletionBlock: {
//                    err, authData in
//                
//                    let user = ["provider": authData.provider!, "email": email, "username": username]
//                    
//                    // Seal the deal in DataService.swift.
//                    SampleDataGenerator.sampleDataGenerator.createNewAccount(authData.uid, user: user)
//                })
//                
//                // Store the uid for future access - handy!
//                NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
//                
//                // Enter the app.
//               // self.performSegueWithIdentifier("NewUserLoggedIn", sender: nil)
//            }
//        })
//        
//    } else {
//         print("error")
//}
//}
//    func tryLogin(email: String, password: String) {
//       
//        
//        if email != "" && password != "" {
//            
//            // Login with the Firebase's authUser method
//            
//            SampleDataGenerator.sampleDataGenerator.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
//                
//                if error != nil {
//                    print("error")
//                
//                } else {
//                    
//                    // Be sure the correct uid is stored.
//                    
//                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
//                    
//                    // Enter the app!
//                    
//                   // self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
//                }
//            })
//            
//        } else {
//            
//            // There was a problem
//            
//           print("error")
//        }
//    }
//    
//class Courses {
//    private var _coursesRef: Firebase!
//    
//    private var _coursesKey: String!
//    private var _coursesText: String!
//    private var _coursesVotes: Int!
//    private var _username: String!
//    
//    var coursesKey: String {
//        return _coursesKey
//    }
//    
//    var coursesText: String {
//        return _coursesText
//    }
//    
//    var coursesVotes: Int {
//        return _coursesVotes
//    }
//    
//    var username: String {
//        return _username
//    }
//    
//    // Initialize the new Joke
//    
//    init(key: String, dictionary: Dictionary<String, AnyObject>) {
//        self._coursesKey = key
//        
//        // Within the Joke, or Key, the following properties are children
//        
//        if let votes = dictionary["votes"] as? Int {
//            self._coursesVotes = votes
//        }
//        
//        if let joke = dictionary["jokeText"] as? String {
//            self._coursesText = joke
//        }
//        
//        if let user = dictionary["author"] as? String {
//            self._username = user
//        } else {
//            self._username = ""
//        }
//        
//        // The above properties are assigned to their key.
//        
//        self._coursesRef = SampleDataGenerator.sampleDataGenerator.COURSE_REF.childByAppendingPath(self._coursesKey)
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//}
