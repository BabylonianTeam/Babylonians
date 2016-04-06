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
        table.rowHeight = 90
        
        searchResult.dataSource = self
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
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.searchResult==tableView) {
            return filtered.count
        }
        return self.publishedCourses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView==self.searchResult {
            let searchcell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchCell
            searchcell.courseTitle.text = filtered[indexPath.row]
            return searchcell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseCell
        
        let course = self.publishedCourses[indexPath.row];
            //Create a unit test for these values
        if let _ = course.title {
            cell.courseTitle.text = course.title
        }
        else {
            cell.courseTitle.text="null"
        }
            //Will probably have to convert some value here to a view count
        cell.courseViewCount.text = "55"
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
                            self.allCourseTitles.append(c.title!)
                        }
                        
                        self.publishedCourses.append(c)
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