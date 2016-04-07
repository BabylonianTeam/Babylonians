//
//  MoreEmailViewController.swift
//  Babylonian
//
//  Created by Ted on 2016/4/3.
//  Copyright © 2016年 Eric Smith. All rights reserved.
//

import UIKit
import Firebase

class MorePasswdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, CustomCellDelegate {
    
    // MARK: Variables
    
    let sections = ["Original Password", "New Password"]
    
    let items = [["Please type original password"],
                 ["Please type new password", "Please type new password again"]
    ]
    
    let cellTypes = [ ["idCellTextfield"],
                      ["idCellTextfield", "idCellTextfield"]
    ]
    
    
    // MARK: Constants
    
    let bigFont = UIFont(name: FONT_BIG, size: CGFloat(FONT_SIZE))
    
    let smallFont = UIFont(name: FONT_SMALL, size: CGFloat(FONT_SIZE))
    
    let primaryColor = UIColor.blackColor()
    
    let secondaryColor = UIColor.lightGrayColor()
    
    var userInfo = PersonalInfo(id: NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String)
    var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    var _BASE_REF = Firebase(url: "\(BASE_URL)")
    
    var account = ""
    
    // MARK: IBOutlet Properties
    @IBOutlet weak var tblExpandable: UITableView!
    
    @IBAction func backToLastPage(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //retrieve displayName from firebase, and display it on More page
        _USER_REF.childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: { snapshot in
            if let content = snapshot.value {
                if let email = (content as! [String:String])[USER_EMAIL] {
                    self.account = email
                }
            }
            
        })
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
        if(cellType == "idLabelCell"){
            cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
        }
        else if(cellType == "idCellTextfield"){
            cell.textField.placeholder = self.items[indexPath.section][indexPath.row]
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
        let cell2 = self.tblExpandable.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as! CustomCell
        
        let passwdOrg = cell0.textField.text!
        let passwd1   = cell1.textField.text!
        let passwd2   = cell2.textField.text!
        
        if((passwd1 != passwd2) || (passwd1.characters.count < 1)){
            handleNewPasswdMismatch()
        }
        else{
            _BASE_REF.changePasswordForUser(self.account, fromOld: passwdOrg, toNew: passwd1, withCompletionBlock: { error in
                if (error != nil){
                    self.handleOrgPasswdMismatch()
                }
                else {
                    print("Change password successfully")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                
            })
            tblExpandable.reloadData()
        }
    }
    
    
    func handleNewPasswdMismatch(){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Password mismatch!", message: "New password cannot be empty nor mismatch", preferredStyle: .Alert)
        
        //Create and an option action
        let retryAction: UIAlertAction = UIAlertAction(title: "Retry", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(retryAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func handleOrgPasswdMismatch(){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Wrong Password!", message: "Please check your original password", preferredStyle: .Alert)
        
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


