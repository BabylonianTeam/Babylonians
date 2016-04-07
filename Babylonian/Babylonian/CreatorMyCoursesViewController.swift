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
    
    var draftCourses = [BBCourse]()
    var publishedCourses = [BBCourse]()
    var allCourseTitles = [String]()
    var filtered = [String]()
    var searchActive : Bool = false
    
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
        
        self.searchResult.hidden = true
        table.reloadData()
        loadMyCourses()
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
        print("button pressed")
        
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
            if section==1 {
                return "Drafts"
            }
            else {
                return "Published"
            }
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
        if tableView==self.table {
            30
            
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        if (self.searchResult==tableView) {
            return filtered.count
        }
        if section==1 {
            return min(self.draftCourses.count,5)
        }
        return min(self.publishedCourses.count,5)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView==self.searchResult {
            print("here")
            let courseId = filtered[indexPath.row].componentsSeparatedByString("|")[0]
            
            let storyboard = UIStoryboard.init(name: "CourseView", bundle: nil)
            let bbCourseController = storyboard.instantiateViewControllerWithIdentifier("BBCourseView") as! BBCourseNavController
            
            bbCourseController.currentCourse = BBCourse(ref: DataService.dataService.COURSE_REF.childByAppendingPath(courseId))
            
            self.presentViewController(bbCourseController, animated: true, completion: nil)

        }
        print("you tab here")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView==self.searchResult {
            let searchcell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchCell
            searchcell.courseTitle.text = filtered[indexPath.row].componentsSeparatedByString("|")[1]
            return searchcell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseCell
     
        if indexPath.section==1 {
            if let t = self.draftCourses[indexPath.row].title{
                cell.courseTitle.text = t
            }
        }
        else{
            if let t = self.publishedCourses[indexPath.row].title {
                cell.courseTitle.text = t
            }
            else {
                cell.courseTitle.text="null"
            }
        }
        
        //Will probably have to convert some value here to a view count
        cell.courseViewCount.text = "55 views"
        cell.profitAmount.text = "$500"
        
        return cell
    }
    
    /*
     * Paramaters: None
     * Connect to Firebase database and pull myCourses data belonging to each user. Since we are using Firebase we don't have to worry about active
     * record!
     */
    
    func loadMyCourses(){
        //TODO Create a test with/ a for loop that hooks in to the database model
        ProgressHUD.show("Loading Courses")
        DataService.dataService.COURSE_REF.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            ProgressHUD.dismiss()
            if let content = snapshot.value {
                if !(content is NSNull) {
                    for (cId,cData) in (content as! [String:NSDictionary]) {
                        let cref = DataService.dataService.COURSE_REF.childByAppendingPath(cId)
                        let c = BBCourse(ref: cref)
                        if let t = cData[COURSE_TITLE]{
                            c.setTitle(t as! String)
                            self.allCourseTitles.append(cId+"|"+c.title!)
                        }
                        if let st = cData[COURSE_STATUS] {
                            if st as! String==COURSE_STATUS_ONSHELF {
                                self.publishedCourses.append(c)
                            }
                            else{
                                self.draftCourses.append(c)
                            }
                        }
                        
                    }
                    self.table.reloadData()
                }
            }
            else{
                //course without content
            }
            
        })
        
    }
}