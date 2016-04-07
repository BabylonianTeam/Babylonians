//
//  CourseSettingViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit
import Firebase
import TagListView


class CourseSettingViewController: UIViewController, TagListViewDelegate{

    var currentCourse: BBCourse!
    var addTagTransfer: String!
    var addTagArray = [String]()
    var fullTagArr: NSArray!
    var tagView = [TagView]()
    var tag: String?
    
    
   
    
    @IBOutlet weak var courseTitle: UITextField!
    @IBOutlet weak var coursePrice: UITextField!
    @IBOutlet weak var courseTag: UITextField!
    

    @IBOutlet weak var tagListView: TagListView!
  
    @IBOutlet weak var bbtitle: UITextView!
    @IBOutlet weak var price: UITextView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
        tagListView.delegate = self
        
        self.currentCourse.courseRef.observeEventType(.Value, withBlock: { snapshot in
           
            if let pricestr = snapshot.value.objectForKey("price"){
                self.price.text = (pricestr as? NSNumber)?.stringValue
            }
            
            if let bbtitlestr = snapshot.value.objectForKey("title"){
                self.bbtitle.text = bbtitlestr as? String
            }
            
            
            if let tagstr = snapshot.value.objectForKey("tag") {
                //self.tagTransfer = (tagstr as? NSArray)!
                self.tag = tagstr as? String
                self.fullTagArr = self.tag!.characters.split{$0 == "|"}.map(String.init)
                self.tagListView.textFont = UIFont.systemFontOfSize(24)
                self.tagListView.alignment = .Center // possible values are .Left, .Center, and .Right
                self.tagListView.removeAllTags()
                for var i = 0; i <= self.fullTagArr.count-1; i++ {
                    let tagstring = self.fullTagArr[i] as? String
                   
                    if let tagview = self.tagListView.addTag(tagstring!) as? TagView{
    
                        self.tagView.append(tagview)
                        
//                        self.tagView[i].onTap = { tagView in
//                            
//                             print(i)
//                            
//                               self.tagListView.removeTag(tagstring!)
 //                       }
                        
                        
//                        tagview.onTap = { tagView in
//                            
//                            print("Don’t tap me!")
//                            if let tagstring = self.fullTagArr[i] as? String {
//                            self.tagListView.removeTag(tagstring)
//                                
//                                
//                                for var j = 0; j<=self.addTagArray.count-2; j++ {
//                                    if self.addTagArray[j] == tagstring {
//                                          self.addTagArray.removeAtIndex(j)
//                                        let stringRepresentation = self.addTagArray.joinWithSeparator("|")
//                                        self.currentCourse.setTag(stringRepresentation, tagArray: self.addTagArray)
//                                        
//                                    }
//                           
//                                }
//                            }
//                            
//                        }
//                        
                        
                        
                        
                        
                    }
                }
                
           }
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
        if self.addTagTransfer == nil{
            self.addTagTransfer = courseTag.text! + "|"
        }
        else {
             self.addTagTransfer = self.addTagTransfer + courseTag.text! + "|"
        }
       
            self.addTagArray.append(courseTag.text!)
       
        currentCourse.setTag(self.addTagTransfer, tagArray: self.addTagArray)
    }
    

    @IBAction func clearAllTag(sender: UIButton) {
        self.addTagTransfer.removeAll()
        self.addTagArray.removeAll()
        currentCourse.deleteAllTag()
        tagListView.removeAllTags()
        
    }
    
    // MARK: UITableView Delegate methods
//    
//    func tableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(self.fullTagArr == nil){
//            return 0
//        }
//        else{
//            return fullTagArr.count
//        }
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("tagCell", forIndexPath: indexPath) as! UITableViewCell
//        
//        if(self.fullTagArr == nil){
//            print("full tag is empty!")
//        }
//        cell.textLabel?.text = self.fullTagArr[indexPath.row] as! String
//        return cell
//    }
//
//    func tableViewScrollToBottom(animated: Bool) {
//        
//        let delay = 0.1 * Double(NSEC_PER_SEC)
//        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//        
//        dispatch_after(time, dispatch_get_main_queue(), {
//            
//            let numberOfSections = self.tableView.numberOfSections
//            let numberOfRows = self.tableView.numberOfRowsInSection(numberOfSections-1)
//            
//            if numberOfRows > 0 {
//                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
//                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
//            }
//            
//        })
//    }
    
    
    
    
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("tagCell") as! UITableViewCell
//        let tagItem = fullTagArr[indexPath.row]
//        
//        
//        return cell
//    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
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
