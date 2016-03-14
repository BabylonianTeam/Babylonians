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
            
           // createAccount("James", email: "james@wisc.edu", password: "123123")
        
        SampleDataGenerator.sampleDataGenerator.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            
           let currentUser = snapshot.value.objectForKey("username") as! String
            
            print("Username: \( snapshot.value.objectForKey("username") as! String)")
            SampleDataGenerator.currentUsername = currentUser
            }, withCancelBlock: { error in
                print(error.description)
        })
    

    
        
        // Do any additional setup after loading the view, typically from a nib.
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && SampleDataGenerator.sampleDataGenerator.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
            
    }
                  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

