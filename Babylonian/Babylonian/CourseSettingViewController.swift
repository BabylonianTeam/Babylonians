//
//  CourseSettingViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit
import Firebase


class CourseSettingViewController: UIViewController {

    var currentCourse: BBCourse!
    var tagTransfer: NSArray!
    var firstTag: NSString!
    
    @IBOutlet weak var courseTitle: UITextField!
    @IBOutlet weak var coursePrice: UITextField!
    @IBOutlet weak var courseTag: UITextField!
    
  
    @IBOutlet weak var bbtitle: UITextView!
    @IBOutlet weak var price: UITextView!
    @IBOutlet weak var tag: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
        
        
        self.currentCourse.courseRef.observeEventType(.Value, withBlock: { snapshot in
            
            
            self.price.text = (snapshot.value.objectForKey("price") as? NSNumber)?.stringValue
            
            //let tagTransfer = snapshot.value.objectForKey("tag")
            
//            for i in 0...2 {
//               self.tag.text = snapshot.value.objectForKey("tag")!.objectForKey(String(i)) as? String
//            }
            
            if let tagstr = snapshot.value.objectForKey("tag") {
                self.tagTransfer = (tagstr as? NSArray)!
            }
            
            self.tag.text = self.tagTransfer.objectAtIndex(0) as! NSString as String
            //  print(snapshot.value.objectForKey("title"))
            
            
            self.bbtitle.text = snapshot.value.objectForKey("title") as? String
            
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
       
        
    }
    

    @IBAction func addCourseTitle(sender: UIButton) {
        
       currentCourse.setTitle(courseTitle.text!)
    }
    
    
    
    @IBAction func addCoursePrice(sender: UIButton) {
        let price = (coursePrice.text! as NSString).floatValue
        currentCourse.setPrice(price)
    }
    
    
 
    @IBAction func addCourseTag(sender: UIButton) {
        
        currentCourse.setTag([courseTag.text!])
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
