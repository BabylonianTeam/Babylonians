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
    
    @IBOutlet weak var courseTitle: UITextField!
    @IBOutlet weak var coursePrice: UITextField!
    @IBOutlet weak var courseTag: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
        
        
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
