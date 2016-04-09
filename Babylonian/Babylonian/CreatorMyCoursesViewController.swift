//
//  CreatorMyCoursesViewController.swift
//  Babylonian

//  Modified by Dongning
//  Created by Eric Smith on 3/16/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit

class CreatorMyCoursesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    //Need to hold a fake db for "Title, Text, and Profit"
    
    //Temporary Value for Testing. Safe to remove once Table Model is implemented
    
    var courseLists = [[MyCourseInfo](),[MyCourseInfo]()]
    var allCourseTitles = [String]()
    var filtered = [String]()
    var searchActive : Bool = false
    let sections = ["Published", "Drafts"]
    var initialized = false
    
    @IBOutlet weak var searchResult: UITableView!
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewWillAppear(animated: Bool) {
        table.reloadData()
    }
    override func viewDidLoad() {
        
        table.delegate = self
        table.dataSource = self
        
        searchResult.dataSource = self
        searchResult.delegate = self
        searchBar.delegate = self
        
        searchResult.registerNib(UINib(nibName: "SearchTableCell", bundle: nil), forCellReuseIdentifier: "SearchTableCell")
        self.searchResult.hidden = true
        table.reloadData()
        loadMyCourses()
        
    }
 
    deinit {
        DataService.dataService.COURSE_REF.removeAllObservers()
    }
    
    //seting search bar
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        self.table.hidden = false
        self.searchResult.hidden = true
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        if let text = self.searchBar.text where !text.isEmpty {
            self.table.hidden = true
            self.searchResult.hidden = false
            self.searchBar.resignFirstResponder()
            print(filtered)
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = allCourseTitles.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.searchResult.reloadData()
    }
    
    
    @IBAction func createNewCourse(sender: UIBarButtonItem) {
            //initiate courseview
        let storyboard = UIStoryboard.init(name: "CourseView", bundle: nil)
        let rootController = storyboard.instantiateViewControllerWithIdentifier("BBCourseView")
        self.presentViewController(rootController, animated: true, completion: nil)
    }
    
    //Setting up tables
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView==self.searchResult {
            return 1
        }
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView==self.table {
            return sections[section]
        }
        return nil
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView==self.table {
            if indexPath.section==0{
                return 60
            }
            else{
                return 35
            }
        }
        else {
            return 35
        }
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.numberOfSections>1 {
            return 30
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        if (self.searchResult==tableView) {
            return filtered.count
        }
        
        return min(self.courseLists[section].count,5)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard.init(name: "CourseView", bundle: nil)
        let bbCourseController = storyboard.instantiateViewControllerWithIdentifier("BBCourseView") as! BBCourseNavController

        if tableView==self.searchResult {
            let courseId = filtered[indexPath.row].componentsSeparatedByString("|")[0]
            
            bbCourseController.currentCourse = BBCourse(ref: DataService.dataService.COURSE_REF.childByAppendingPath(courseId))

        }
        else {
            bbCourseController.currentCourse = BBCourse(ref: self.courseLists[indexPath.section][indexPath.row].ref)
        }
        self.presentViewController(bbCourseController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView==self.searchResult {
            let searchcell = tableView.dequeueReusableCellWithIdentifier("SearchTableCell", forIndexPath: indexPath) as! SearchTableCell
            searchcell.courseTitle.text = filtered[indexPath.row].componentsSeparatedByString("|")[1]
            return searchcell
        }
        if indexPath.section==0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseCell
            cell.courseTitle.text = self.courseLists[indexPath.section][indexPath.row].title
            
            cell.courseViewCount.text = String(self.courseLists[indexPath.section][indexPath.row].NoV)
            cell.profitAmount.text = String(self.courseLists[indexPath.section][indexPath.row].income)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DraftCell", forIndexPath: indexPath) as! DraftCell
        cell.courseTitle.text = self.courseLists[indexPath.section][indexPath.row].title
        return cell
        
    }
    
    /*
     * Paramaters: None
     * Connect to Firebase database and pull myCourses data belonging to each user. Since we are using Firebase we don't have to worry about active
     * record!
     */
    
    func loadMyCourses(){
        //TODO Create a test with/ a for loop that hooks in to the database model
        self.initialized = false
        ProgressHUD.show("Loading Courses")
        
        DataService.dataService.COURSE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            if self.initialized {
                
                //let c = BBCourse(ref: snapshot.ref)
                var title:String!
                if let t = snapshot.value.objectForKey(COURSE_TITLE) {
                    title = t as! String
                }else {
                    title = "(no title)"
                }
                self.allCourseTitles.append(snapshot.key+"|"+title)
                let cInfo = MyCourseInfo(ref: snapshot.ref, title:title)
                if let st = snapshot.value.objectForKey(COURSE_STATUS) {
                    if  st as! String == COURSE_STATUS_ONSHELF{
                        self.courseLists[0].append(cInfo)
                    }
                    else{
                        self.courseLists[1].append(cInfo)
                    }
                }
                else {
                    //Added New Course, AutoId triggered event
                    self.courseLists[1].append(cInfo)
                }
                
            }
        })
    
        DataService.dataService.COURSE_REF.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            ProgressHUD.dismiss()
            
            if let content = snapshot.value {
                if !(content is NSNull) {
                    for (cId,cData) in (content as! [String:NSDictionary]) {
                        let cref = DataService.dataService.COURSE_REF.childByAppendingPath(cId)
                        
                        var title:String!
                        if let t = cData.objectForKey(COURSE_TITLE) {
                            title = t as! String
                        }else {
                            title = "(no title)"
                        }
                        self.allCourseTitles.append(snapshot.key+"|"+title)
                        let cInfo = MyCourseInfo(ref: cref, title:title)
                        
                        if let st = cData[COURSE_STATUS] {
                            if st as! String==COURSE_STATUS_ONSHELF {
                                self.courseLists[0].append(cInfo)
                            }
                            else{
                                self.courseLists[1].append(cInfo)
                            }
                        }
                        
                    }
                    self.table.reloadData()
                }
            }
            else{
                //course without content
            }
            self.initialized = true
        })
        
    }
}