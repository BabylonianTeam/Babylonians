//
//  CourseSettingViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit
import Firebase


class CourseSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var currentCourse: BBCourse!
    var tagTransfer: NSArray!
    var fullTagArr: NSArray!
    var firstTag: NSString!
    
    @IBOutlet weak var courseTitle: UITextField!
    @IBOutlet weak var coursePrice: UITextField!
    @IBOutlet weak var courseTag: UITextField!
    
 
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var bbtitle: UITextView!
    @IBOutlet weak var price: UITextView!
    @IBOutlet weak var tag: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
       self.tableView.dataSource = self
        currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
        // Set up swipe to delete
       // tableView.allowsMultipleSelectionDuringEditing = false
        
        self.currentCourse.courseRef.observeEventType(.Value, withBlock: { snapshot in
            
            
        self.price.text = (snapshot.value.objectForKey("price") as? NSNumber)?.stringValue
        self.bbtitle.text = snapshot.value.objectForKey("title") as? String
            
            self.tagTransfer = (snapshot.value.objectForKey("tag") as? NSArray)!
            self.tag.text = self.tagTransfer.objectAtIndex(0) as! NSString as String
            
            let fullTagArr = self.tag.text.characters.split{$0 == "|"}.map(String.init)
            
            print(fullTagArr) // First
          //  print(fullTagArr[1]) // Last
            
            self.tableView.reloadData()
            
            
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
    

    // MARK: UITableView Delegate methods
    
    func tableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(fullTagArr == nil){
            return 0
        }
        else{
            return fullTagArr.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tagCell", forIndexPath: indexPath) as! UITableViewCell
        
        if(fullTagArr==nil){
            print("full tag is empty!")
        }
        cell.textLabel?.text = fullTagArr[indexPath.row] as! String
        return cell
    }

    
    
    
    
    
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("tagCell") as! UITableViewCell
//        let tagItem = fullTagArr[indexPath.row]
//        
//        
//        return cell
//    }
    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            
//            // Find the snapshot and remove the value
//            let groceryItem = fullTagArr[indexPath.row]
//            
//            // Using the optional ref property, remove the value from the database
//            groceryItem.ref?.removeValue()
//            
//        }
//    }
    
    


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
