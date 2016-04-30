//
//  MoreEmailViewController.swift
//  Babylonian
//
//  Created by Ted on 2016/4/3.
//  Copyright © 2016年 Eric Smith. All rights reserved.
//

import UIKit
import Firebase

class LearnerMoreEmailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, CustomCellDelegate {
    
        // MARK: Variables
        
    let sections = ["Current E-mail", "New E-mail", "Current Password"]
    
    let items = [["xxx@com"],
                 ["Please type new address"],
                 ["Please enter current password"]
    ]
    
    let cellTypes = [ ["idCellValuePicker"],
                      ["idCellTextfield"],
                      ["idCellTextfield"]
    ]
    
    
    // MARK: Constants
        
    let bigFont = UIFont(name: FONT_BIG, size: CGFloat(FONT_SIZE))
    
    let smallFont = UIFont(name: FONT_SMALL, size: CGFloat(FONT_SIZE))
        
    let primaryColor = UIColor.blackColor()
        
    let secondaryColor = UIColor.lightGrayColor()
    
    var userInfo : PersonalInfo!
    
    var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    var _BASE_REF = Firebase(url: "\(BASE_URL)")
    
    // MARK: IBOutlet Properties
    @IBOutlet weak var tblExpandable: UITableView!
    
    @IBAction func backToLastPage(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            userInfo = PersonalInfo(id: NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String)
            
            configureTableView()
        }
    
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)

            //userInfo.updatePassword("abc@abc.com", oldPassword: "asdfghjkl", newPassword: "bcd")
            /*
            _BASE_REF.changePasswordForUser("abc@abc.com", fromOld: "asdfghjkl", toNew: "abc", withCompletionBlock: { error in
                if (error != nil){
                    print("error message")
                }
                else {
                    print("Change password successfully")
                }
                
            })
            */
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func configureTableView() {
            tblExpandable.delegate = self
            tblExpandable.dataSource = self
            tblExpandable.tableFooterView = UIView(frame: CGRectZero)
            
            tblExpandable.registerNib(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "idLabelCell")
            tblExpandable.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
            tblExpandable.registerNib(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
            tblExpandable.registerNib(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
            tblExpandable.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
            tblExpandable.registerNib(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
            tblExpandable.registerNib(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
        }
        
        // MARK: UITableView Delegate and Datasource Functions
        
        // Number of sections
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return self.sections.count
        }
        
        // Number of rows in each section
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
                _USER_REF.childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: { snapshot in
                    if let email = snapshot.value[USER_EMAIL] as? String {
                        cell.textLabel?.text = email
                    }
                })
            }
            
            else if(cellType == "idLabelCell"){
                cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
            }
            else if(cellType == "idCellTextfield"){
                cell.textField.placeholder = self.items[indexPath.section][indexPath.row]
                
                if(indexPath.section == 2 && indexPath.row == 0){
                    cell.textField.secureTextEntry = true
                }
            }
            else if(cellType == "idCellValuePicker"){
                cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
            }
            
            return cell
            
        }
        
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 50.0
        }
    
        /*
        func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
        }*/
    
        /*
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if(indexPath.section < 1){
                performSegueWithIdentifier("ts", sender: self)
            }
        }
        */

    @IBAction func changeConfirm(sender: AnyObject) {
        let cell0 = self.tblExpandable.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! CustomCell
        let cell1 = self.tblExpandable.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! CustomCell
        let cell2 = self.tblExpandable.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! CustomCell
        
        let oldAddr = cell0.textLabel!.text!
        let newAddr = cell1.textField.text!
        let passwd  = cell2.textField.text!
        
        if((oldAddr == newAddr)){
            handleEmailSame()
        }
        else if(newAddr.containsString("@") == false || newAddr.containsString(".") == false){
            handleInvalidEmail()
        }
        else if(newAddr.containsString(".edu") == false && newAddr.containsString(".com") == false){
            handleInvalidEmail()
        }
        else{
            _BASE_REF.changeEmailForUser(oldAddr, password: passwd, toNewEmail: newAddr, withCompletionBlock: { error in
                if (error != nil){
                    self.handleUpdateError()
                }
                else {
                    print("Change email successfully")
                    self.userInfo.updateEmail(newAddr)
                    self.tblExpandable.reloadData()
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                
            })
        }
    }
    

    func handleUpdateError(){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Update Fail!", message: "Please check your password", preferredStyle: .Alert)
        
        //Create and an option action
        let retryAction: UIAlertAction = UIAlertAction(title: "Retry", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(retryAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func handleInvalidEmail(){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Invalid Email Address!", message: "Please check the new address is valid", preferredStyle: .Alert)
        
        //Create and an option action
        let retryAction: UIAlertAction = UIAlertAction(title: "Retry", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(retryAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    
    func handleEmailSame(){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Email Unchanged!", message: "New E-mail is identical to the old one!", preferredStyle: .Alert)
        
        /*
         //Create and add the Setting action
         let settingAction: UIAlertAction = UIAlertAction(title: "Setting", style: .Cancel) { action -> Void in
         //Do some stuff
         UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
         }
         actionSheetController.addAction(settingAction)
         */
        
        //Create and an option action
        let retryAction: UIAlertAction = UIAlertAction(title: "Retry", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(retryAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
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
            tblExpandable.reloadData()
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
            tblExpandable.reloadData()
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
            
            tblExpandable.reloadData()
        }
        
        
        func sliderDidChangeValue(newSliderValue: String) {
            /*
            cellDescriptors[2][0].setValue(newSliderValue, forKey: "primaryTitle")
            cellDescriptors[2][1].setValue(newSliderValue, forKey: "value")
            */
            
            tblExpandable.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.None)
        }
        
}


