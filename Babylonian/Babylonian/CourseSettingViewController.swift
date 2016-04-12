//
//  CourseSettingViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/2/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit
import Firebase
import TagListView


class CourseSettingViewController: UIViewController, UITextFieldDelegate, TagListViewDelegate{

    var currentCourse: BBCourse!
    var tagStr: String?
    var tagArray = [String]()
    var tagView = [TagView]()
    var newData = [String]()
    var buttonData = [String]()
    
    
   
    
    @IBOutlet weak var courseTitle: UITextField!
    @IBOutlet weak var coursePrice: UITextField!
    @IBOutlet weak var courseTag: UITextField!
    

    @IBOutlet weak var tagListView: TagListView!
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newData = ["Course Title:", "Course Price:", "Course Tag:"]
        buttonData = ["add", "add", "add"]
        self.title = "Setings"
        currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
        tagListView.delegate = self
        courseTitle.delegate = self
        coursePrice.delegate = self
        courseTag.delegate = self
       
        
        
        
        self.currentCourse.courseRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
           
            if let pricestr = snapshot.value.objectForKey(COURSE_PRICE){
                self.coursePrice.text = (pricestr as? NSNumber)?.stringValue
            }
            
            if let bbtitlestr = snapshot.value.objectForKey("title"){
                self.courseTitle.text = bbtitlestr as? String
            }
            
            
            if let tagstr = snapshot.value.objectForKey("tag") {
                //self.tagTransfer = (tagstr as? NSArray)!
                self.tagStr = tagstr as? String
                self.tagArray = self.tagStr!.componentsSeparatedByString("|")
                self.tagListView.textFont = UIFont.systemFontOfSize(24)
                self.tagListView.alignment = .Center // possible values are .Left, .Center, and .Right
                self.tagListView.removeAllTags()
                for i in 0...(self.tagArray.count-1) {
                    let tagstring = self.tagArray[i]
                   
                    if let tagview = self.tagListView.addTag(tagstring) as? TagView{
    
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
    
//    
//    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
//        switch textField {
//        case self.courseTitle:
//            currentCourse.setTitle(courseTitle.text!)
//            return true
//        case self.coursePrice:
//            currentCourse.setPrice(coursePrice.text!.floatValue)
//            return true
//        case self.courseTag:
//            addTag()
//            return true
//        default:
//            return true
//        }
//    }
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        if(string == "\n") {
//            switch textField {
//            case self.courseTitle:
//                currentCourse.setTitle(courseTitle.text!)
//                textField.resignFirstResponder()
//                return false
//            case self.coursePrice:
//                print("priced")
//                currentCourse.setPrice(coursePrice.text!.floatValue)
//                return false
//            case self.courseTag:
//                addTag()
//                return true
//            default: break
//            }
//            textField.resignFirstResponder()
//            return false
//        }
//        return true
//    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case self.courseTitle:
            currentCourse.setTitle(courseTitle.text!)
        case self.coursePrice:
            print("priced")
            currentCourse.setPrice(coursePrice.text!.floatValue)
        case self.courseTag:
            addTag()
            
        default:break
        }
        textField.resignFirstResponder()
        return true
    }
    
 
    @IBAction func addCourseTag(sender: UIButton) {
       addTag()
    }
    
    @IBAction func Publish(sender: UIButton) {
        self.currentCourse.setStatus(COURSE_STATUS_ONSHELF)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func clearAllTag(sender: UIButton) {
        self.tagArray.removeAll()
        currentCourse.deleteAllTag()
        tagListView.removeAllTags()
        
    }
    
    func addTag() -> Void {

        if let t = courseTag.text{
            
            if t.trim().characters.count>0 {
                self.tagArray.append(t)
                
                self.tagStr=self.tagArray.joinWithSeparator("|")
                currentCourse.setTag(self.tagArray)
                self.tagListView.addTag(t)
            }
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //This function returns number of rows in table view
    }
    
    
    
    
    func tableView(tableView: UITableView!,
                   cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"TextfieldCell")
       
        cell.textLabel?.text = newData[indexPath.row]
        
        
        var input = UITextField(frame: CGRectMake(130.0, 14.0, 150.0, 30.0))
        
        input.tag = indexPath.row
        cell.contentView.addSubview(input)
        
//        let btn = UIButton(type: UIButtonType.Custom) as UIButton
//        btn.backgroundColor = UIColor.lightGrayColor()
//        btn.setTitle(buttonData[indexPath.row], forState: UIControlState.Normal)
//        btn.frame = CGRectMake(0, 5, 80, 40)
//        btn.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        btn.tag = indexPath.row
//        cell.contentView.addSubview(btn)
        
        return cell
    }
    
    
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//    {
//        
//        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
//        
//        var label = UILabel(frame: CGRectMake(280.0, 14.0, 100.0, 30.0))
//        label.text = newData[indexPath.row]
//        label.tag = indexPath.row
//        cell.contentView.addSubview(label)
//        
//        
//        let btn = UIButton(type: UIButtonType.Custom) as UIButton
//        btn.backgroundColor = UIColor.greenColor()
//        btn.setTitle(newData[indexPath.row], forState: UIControlState.Normal)
//        btn.frame = CGRectMake(0, 5, 80, 40)
//        btn.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        btn.tag = indexPath.row
//        cell.contentView.addSubview(btn)
//        
//        return cell
//    }
//    
//    //Button Action is
//    func buttonPressed(sender:UIButton!)
//    {
//        let buttonRow = sender.tag
//        print("button is Pressed")
//        print("Clicked Button Row is",buttonRow)
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
