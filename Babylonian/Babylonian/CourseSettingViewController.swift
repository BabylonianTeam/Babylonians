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


class CourseSettingViewController: UIViewController, UITextFieldDelegate, TagListViewDelegate,  UITableViewDelegate, UITableViewDataSource, CustomCellDelegate{

    var currentCourse: BBCourse!
    var tagStr: String?
    var tagView = [TagView]()
    var newData = [String]()
    var buttonData = [String]()
    var newtag: String?
    var newprice: String?
    var newtitle: String?
    var currCreator: CreatorInfo!

    
    @IBOutlet weak var mytableView: UITableView!
  
    
    let sections = ["Course Title", "Course Price", "Course Tag"]
    let items = [["Please type Course Title"],
                 ["Please type Course Price"],
                 ["Please type Course Tag"]
    ]
    let cellTypes = [ ["setCoursetTitle"],
                      ["setCoursePrice"],
                      ["tagViewCell"]
    ]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currCreator = CreatorInfo(id: NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String)
        self.title = "Settings"
        currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
        
        configureTableView()
        
        self.currentCourse.courseRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let tagstr = snapshot.value.objectForKey("tag") {
                //self.tagTransfer = (tagstr as? NSArray)!
                self.tagStr = tagstr as? String
                self.currentCourse.tag_ = self.tagStr!.characters.split{$0 == "|"}.map(String.init)
                self.mytableView.reloadData()
                
//                self.tagListView.textFont = UIFont.systemFontOfSize(24)
//                self.tagListView.alignment = .Center // possible values are .Left, .Center, and .Right
//                self.tagListView.removeAllTags()
//                for i in 0...(self.tagArray.count-1) {
//                    let tagstring = self.tagArray[i]
//                   
//                    if let tagview = self.tagListView.addTag(tagstring) as? TagView{
    
                   //
               // self.tagView.append(tagview)
                        
                        
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
                
                        
//                        
//                    }
//                }
                
           }
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
        
    }
    
    @IBAction func saveToDraft(sender: UIButton) {
        let cell1 = self.mytableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! SetCourseTitle
        
        let cell2 = self.mytableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! SetCoursePrice
        
        //let cell3 = self.mytableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! TagViewCell
        //self.newtag = cell3.tagListView.
        
        currentCourse.setPrice(cell2.price.text!.floatValue)
        currentCourse.setTitle(cell1.title.text!)
        self.currentCourse.setStatus(COURSE_STATUS_DRAFT)
        self.currentCourse.setTag(self.currentCourse.tag)
        self.currCreator.creatorRef.childByAppendingPath(USER_CREATED_COURSE).childByAppendingPath(currentCourse.courseRef.key).setValue([USER_MODIFIED_COURSE_DATE:getCurrentDateTime()])
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }


    
    @IBAction func Publish(sender: UIButton) {
        
        let cell1 = self.mytableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! SetCourseTitle
        
        let cell2 = self.mytableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! SetCoursePrice
        
        currentCourse.setPrice(cell2.price.text!.floatValue)
        currentCourse.setTitle(cell1.title.text!)
        self.currentCourse.setStatus(COURSE_STATUS_ONSHELF)
        self.currentCourse.setTag(self.currentCourse.tag)
        self.currCreator.creatorRef.childByAppendingPath(USER_CREATED_COURSE).childByAppendingPath(currentCourse.courseRef.key).setValue([USER_MODIFIED_COURSE_DATE:getCurrentDateTime()])
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func configureTableView() {
        mytableView.delegate = self
        mytableView.dataSource = self
        mytableView.tableFooterView = UIView(frame: CGRectZero)
        
        mytableView.registerNib(UINib(nibName: "TagViewCell", bundle: nil), forCellReuseIdentifier: "tagViewCell")
        mytableView.registerNib(UINib(nibName: "SetCourseTitle", bundle: nil), forCellReuseIdentifier: "setCoursetTitle")
        mytableView.registerNib(UINib(nibName: "SetCoursePrice", bundle: nil), forCellReuseIdentifier: "setCoursePrice")
    }

    
    // Number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    
    // Title for each section
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }

    
    // Generate a cell for each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellType = self.cellTypes[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellType, forIndexPath: indexPath)
        
        
        // Configure the cell...
        
        if(indexPath.section == 0 && indexPath.row == 0){
            let tcell = cell as! SetCourseTitle
            tcell.currentCourse = self.currentCourse
           self.currentCourse.courseRef.observeEventType(.Value, withBlock: { snapshot in
            
            if let bbtitlestr = snapshot.value.objectForKey("title"){
                tcell.title.text = bbtitlestr as? String
            }
            if (tcell.title.text ?? "").isEmpty {
                tcell.title.placeholder = "Please type Course Title"
            }
            
            }, withCancelBlock: { error in
                print(error.description)
           })
            return tcell

        }
            
        else if(indexPath.section == 1 && indexPath.row == 0){
            let pcell = cell as! SetCoursePrice
            pcell.currentCourse = self.currentCourse
            self.currentCourse.courseRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                
                if let pricestr = snapshot.value.objectForKey(COURSE_PRICE){
                    pcell.price.text = (pricestr as? NSNumber)?.stringValue
                }
                if (pcell.price.text ?? "").isEmpty {
                    pcell.price.placeholder = "Please type Course Price"
                }
                
                }, withCancelBlock: { error in
                    print(error.description)
            })
            
                   return pcell
                  }
        
        let tcell = cell as! TagViewCell
        tcell.textField.placeholder = "Please type Course Tag here"
        tcell.currentCourse = self.currentCourse
        tcell.refreshTags()
        return tcell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }

    
    
    
    //==============================================================
    // MARK: CustomCellDelegate Functions
    //==============================================================
    func dateWasSelected(selectedDateString: String) {
        /*
         let dateCellSection = 0
         let dateCellRow = 3
         
         cellDescriptors[dateCellSection][dateCellRow].setValue(selectedDateString, forKey: "primaryTitle")
         */
        mytableView.reloadData()
    }
    
    
    func maritalStatusSwitchChangedState(isOn: Bool) {
        /*
         let maritalSwitchCellSection = 0
         let maritalSwitchCellRow = 6
         
         let valueToStore = (isOn) ? "true" : "false"
         let valueToDisplay = (isOn) ? "Married" : "Single"
         
         cellDescriptors[maritalSwitchCellSection][maritalSwitchCellRow].setValue(valueToStore, forKey: "value")
         cellDescriptors[maritalSwitchCellSection][maritalSwitchCellRow - 1].setValue(valueToDisplay, forKey: "primaryTitle")
         */
        mytableView.reloadData()
    }
    
    
    func textfieldTextWasChanged(newText: String, parentCell: CustomCell) {
        /*
         let parentCellIndexPath = tblExpandable.indexPathForCell(parentCell)
         
         
         let currentFullname = cellDescriptors[0][0]["primaryTitle"] as! String
         let fullnameParts = currentFullname.componentsSeparatedByString(" ")
         
         var newFullname = ""
         
         if parentCellIndexPath?.row == 1 {
         if fullnameParts.count == 2 {
         newFullname = "\(newText) \(fullnameParts[1])"
         }
         else {
         newFullname = newText
         }
         }
         else {
         newFullname = "\(fullnameParts[0]) \(newText)"
         }
         
         cellDescriptors[0][0].setValue(newFullname, forKey: "primaryTitle")
         */
        
        mytableView.reloadData()
    }
    
    
    func sliderDidChangeValue(newSliderValue: String) {
        /*
         cellDescriptors[2][0].setValue(newSliderValue, forKey: "primaryTitle")
         cellDescriptors[2][1].setValue(newSliderValue, forKey: "value")
         */
        
        mytableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.None)
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
