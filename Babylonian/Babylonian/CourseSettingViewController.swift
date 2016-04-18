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
    var tagArray = [String]()
    var tagView = [TagView]()
    var newData = [String]()
    var buttonData = [String]()
    var newtag: String?
    var newprice: String?
    var newtitle: String?
    
    
    @IBOutlet weak var mytableView: UITableView!
    @IBOutlet weak var tagListView: TagListView!
  
    
    let sections = ["Course Title", "Course Price", "Course Tag"]
    let items = [["Please type Course Title", ""],
                 ["Please type Course Price", ""],
                 ["Please type Course Tag"]
    ]
    let cellTypes = [ ["idLabelCell", "idCellTextfield"],
                      ["idLabelCell","idCellTextfield"],
                      ["idCellTextfield"]
    ]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setings"
        currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
        tagListView.delegate = self
        
        configureTableView()
        
        self.currentCourse.courseRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            
            
            if let tagstr = snapshot.value.objectForKey("tag") {
                //self.tagTransfer = (tagstr as? NSArray)!
                self.tagStr = tagstr as? String
                self.tagArray = self.tagStr!.characters.split{$0 == "|"}.map(String.init)
                self.currentCourse.tag_ = self.tagArray
                self.tagListView.textFont = UIFont.systemFontOfSize(24)
                self.tagListView.alignment = .Center // possible values are .Left, .Center, and .Right
                self.tagListView.removeAllTags()
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
    

    
 
    @IBAction func addCourseTag(sender: UIButton) {
       addTag()
    }
    
    @IBAction func Publish(sender: UIButton) {
        
        let cell1 = self.mytableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! CustomCell
        
        self.newtitle = cell1.textField.text!
       
        let cell2 = self.mytableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as! CustomCell
        
        self.newprice = cell2.textField.text!
        

        currentCourse.setPrice(self.newprice!.floatValue)
         currentCourse.setTitle(self.newtitle!)
        self.currentCourse.setStatus(COURSE_STATUS_ONSHELF)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func clearAllTag(sender: UIButton) {
        self.tagArray.removeAll()
        currentCourse.deleteAllTag()
        tagListView.removeAllTags()
        
    }
    
    func addTag() -> Void {
        
        let cell3 = self.mytableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! CustomCell
        self.newtag = cell3.textField.text!
        
        if let t = self.newtag{
            
            if t.trim().characters.count>0 {
                self.tagArray.append(t)
                
                self.tagStr=self.tagArray.joinWithSeparator("|")
                currentCourse.setTag(self.tagArray)
                self.tagListView.addTag(t)
            }
        }
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func configureTableView() {
        mytableView.delegate = self
        mytableView.dataSource = self
        mytableView.tableFooterView = UIView(frame: CGRectZero)
        
        mytableView.registerNib(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "idLabelCell")
        mytableView.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        mytableView.registerNib(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
        mytableView.registerNib(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
        mytableView.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
        mytableView.registerNib(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
        mytableView.registerNib(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
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
        
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("idLabelCell", forIndexPath: indexPath)
        let cellType = self.cellTypes[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellType, forIndexPath: indexPath) as! CustomCell
        
        
        // Configure the cell...
        
        if(indexPath.section == 0 && indexPath.row == 0){
           self.currentCourse.courseRef.observeEventType(.Value, withBlock: { snapshot in
            
            if let bbtitlestr = snapshot.value.objectForKey("title"){
                cell.textLabel?.text = bbtitlestr as? String
            }
            
            
            
            }, withCancelBlock: { error in
                print(error.description)
           })

        }
        else if(indexPath.section == 0 && indexPath.row == 1){
            
                
                cell.textField.placeholder = "Please type Course Title"
            
           
            
            
        }
            
        else if(indexPath.section == 1 && indexPath.row == 0){
            self.currentCourse.courseRef.observeEventType(.Value, withBlock: { snapshot in
                
                
                if let pricestr = snapshot.value.objectForKey(COURSE_PRICE){
                    cell.textLabel?.text = (pricestr as? NSNumber)?.stringValue
                }
                
                
                
                }, withCancelBlock: { error in
                    print(error.description)
            })
            
        }
            
        else if(indexPath.section == 1 && indexPath.row == 1){
            
               cell.textField.placeholder = "Please type Course Price"
            
            
            
        }
        
        else if(indexPath.section == 2 && indexPath.row == 0){
            
            
            
            cell.textField.placeholder = "Please type Course Tag here"
            
            
        }

        
       
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func tableView(tableView: UITableView!,
//                   
//                   cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
//    {
//        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"TextfieldCell")
//        
//        cell.textLabel?.text = newData[indexPath.row]
//        
//        
//        var input = UITextField(frame: CGRectMake(130.0, 14.0, 150.0, 30.0))
//        
//        input.tag = indexPath.row
//        cell.contentView.addSubview(input)
//        
//        //        let btn = UIButton(type: UIButtonType.Custom) as UIButton
//        //        btn.backgroundColor = UIColor.lightGrayColor()
//        //        btn.setTitle(buttonData[indexPath.row], forState: UIControlState.Normal)
//        //        btn.frame = CGRectMake(0, 5, 80, 40)
//        //        btn.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        //        btn.tag = indexPath.row
//        //        cell.contentView.addSubview(btn)
//        
//        return cell
//    }
    

    
    
    
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
