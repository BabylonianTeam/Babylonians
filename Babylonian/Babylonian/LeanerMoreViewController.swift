//
//  MoreUIViewController.swift
//  Babylonian
//
//  Created by Ted on 2016/3/17.
//  Copyright © 2016年 Eric Smith. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import Parse

class LearnerMoreViewController: UIViewController, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate,CustomCellDelegate {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var labelDisplayName: UILabel!
    @IBOutlet weak var labelMoney: UILabel!
    
    // MARK: Variables
    
    let sections = ["Account", "Privacy"]
    
    let items = [["Display Name", "Profile Photo", "E-mail", "Password"],
                 ["Show Location", "Connected to FB", "Connected to Twitter"]
    ]
    
    let cellTypes = [ ["idLabelCell", "idLabelCell", "idLabelCell", "idLabelCell"],
                      ["idCellSwitch", "idCellSwitch", "idCellSwitch"]
    ]
    
    
    // MARK: Constants
    
    let bigFont = UIFont(name: FONT_BIG, size: CGFloat(FONT_SIZE))
    
    let smallFont = UIFont(name: FONT_SMALL, size: CGFloat(FONT_SIZE))
    
    let primaryColor = UIColor.blackColor()
    
    let secondaryColor = UIColor.lightGrayColor()
    
    var imagePicker = UIImagePickerController()
    
    
    var userInfo : PersonalInfo!
    var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    
    
    // MARK: IBOutlet Properties
    @IBOutlet weak var tblExpandable: UITableView!
    
    
    /*
     func retrieveData(){
     //retrieve displayName from firebase, and display it on More page
     _USER_REF.childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: { snapshot in
     if let displayName = snapshot.value["displayName"] as? String {
     self.FdisplayName = displayName
     print("displayName is \(self.FdisplayName)")
     }
     })
     }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userInfo = PersonalInfo(id: NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String)
        
        self.imagePicker.delegate = self
        configureTableView()
        
        labelDisplayName?.font = bigFont
        labelMoney?.font = bigFont
        
        //retrieve displayName from firebase, and display it on More page
        _USER_REF.childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: { snapshot in
            if let content = snapshot.value {
                if let displayName = (content as! [String:AnyObject])[USER_DISPLAYNAME] {
                    self.labelDisplayName?.text = displayName as? String
                }
            }
            
        })
        
        ProgressHUD.show("Loading...")
        // retriebe profile photo
        _USER_REF.childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: { snapshot in
            if let content = snapshot.value {
                if let url = (content as! [String:AnyObject])[USER_PROFILEPHOTO] {
                    
                    if let nsURL = NSURL(string: url as! String) {
                        self.profilePhoto.sd_setImageWithURL(nsURL, placeholderImage: UIImage(named: "person-placeholder.png"))
                    }
                }
            }
            ProgressHUD.dismiss()
        })
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        //set the detailTextLabel
        if(cellType == "idLabelCell"){
            
            cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
            
            if(cell.textLabel?.text == "Display Name"){
                cell.detailTextLabel?.text = " "
                _USER_REF.childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: { snapshot in
                    if let content = snapshot.value {
                        if let displayName = (content as! [String:AnyObject])[USER_DISPLAYNAME] {
                            cell.detailTextLabel?.text = displayName as? String
                        }
                    }
                    
                })
            }
            else if(cell.textLabel?.text == "E-mail"){
                cell.detailTextLabel?.text = " "
                _USER_REF.childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: { snapshot in
                    if let content = snapshot.value {
                        if let email = (content as! [String:AnyObject])[USER_EMAIL] {
                            cell.detailTextLabel?.text = email as? String
                        }
                    }
                    
                })
            }
            else{
                cell.detailTextLabel?.text = " "
            }
        }
        else if(cellType == "idCellSwitch"){
            cell.lblSwitchLabel?.text = self.items[indexPath.section][indexPath.row]
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard.init(name: "LearnerMore", bundle: nil)
        
        if((indexPath.section == 0) && (indexPath.row == 2)){
            //performSegueWithIdentifier("emailSegue", sender: self)
            let changeController = storyboard.instantiateViewControllerWithIdentifier("LearnerMoreEmailView") as! LearnerMoreEmailViewController
            self.presentViewController(changeController, animated: true, completion: nil)
        }
            
        else if((indexPath.section == 0) && (indexPath.row == 0)){
            //performSegueWithIdentifier("nameSegue", sender: self)
            let changeController = storyboard.instantiateViewControllerWithIdentifier("LearnerMoreNameView") as! LearnerMoreNameViewController
            self.presentViewController(changeController, animated: true, completion: nil)
        }
            
        else if((indexPath.section == 0) && (indexPath.row == 3)){
            //performSegueWithIdentifier("passwdSegue", sender: self)
            let changeController = storyboard.instantiateViewControllerWithIdentifier("LearnerMorePasswdView") as! LearnerMorePasswdViewController
            self.presentViewController(changeController, animated: true, completion: nil)
        }
            
        else if((indexPath.section == 0) && (indexPath.row == 1)){
            changeImageItem()
        }
    }
    
    /*
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     let storyboard = UIStoryboard.init(name: "CourseView", bundle: nil)
     let bbCourseController = storyboard.instantiateViewControllerWithIdentifier("BBCourseView") as! BBCourseNavController
     
     if tableView==self.searchResult {
     let courseId = filtered[indexPath.row].componentsSeparatedByString("|")[0]
     
     bbCourseController.currentCourse = BBCourse(ref: DataService.dataService.COURSE_REF.childByAppendingPath(courseId))
     
     }
     else {
     bbCourseController.currentCourse = self.courseLists[indexPath.section][indexPath.row]
     }
     self.presentViewController(bbCourseController, animated: true, completion: nil)
     }*/
    
    
    @IBAction func logoutPressed(sender: AnyObject) {
        DataService.dataService.BASE_REF.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [WelcomeView()]
        
        
        appDelegate.window!.rootViewController = navigationController
        appDelegate.window!.makeKeyAndVisible()
    }
    
    func changeImageItem() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        let data = UIImageJPEGRepresentation(image!, 0.5)
        let imageFile = PFFile(name: "image.jpg", data: data!)
        
        print(imageFile?.url)
        let pObject = PFObject(className: "Image")
        pObject[PARSE_IMAGE_FILENAME]  = imageFile
        
        
        
        pObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                if let stringUrl = imageFile?.url {
                    print("update url \(stringUrl)")
                    //ProgressHUD.show("Loading...")
                    
                    if let url = NSURL(string: stringUrl ) {
                        self.profilePhoto.sd_setImageWithURL(url, placeholderImage: UIImage(named: "person-placeholder.png"))
                        self.userInfo.updateProfilePhoto(stringUrl)
                    }
                    //ProgressHUD.dismiss()
                }
                
            }else {
                print("update profile photho error")
            }
        }
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


