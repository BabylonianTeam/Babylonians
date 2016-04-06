//
//  CreatorMyCoursesViewController.swift
//  Babylonian
//
//  Created by Eric Smith on 3/16/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit

class CreatorMyCoursesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    //Need to hold a fake db for "Title, Text, and Profit"
    
    //Temporary Value for Testing. Safe to remove once Table Model is implemented
    
    var draftCourses = [BBCourse]()
    var publishedCourses = [BBCourse]()
    
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
    
    
    //Setting up table
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.publishedCourses.count
    }
    
    /*
    * Paramaters: None
    * Connect to Firebase database and pull myCourses data belonging to each user. Since we are using Firebase we don't have to worry about active
    * record!
    */
    
    @IBAction func createButton(sender: UIButton) {
        //initiate courseview
        let storyboard = UIStoryboard.init(name: "CourseView", bundle: nil)
        
        let rootController = storyboard.instantiateViewControllerWithIdentifier("BBCourseView")
        print("button pressed")
        
        self.presentViewController(rootController, animated: true, completion: nil)
    }
    
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
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView==self.searchResult {
            let searchcell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchCell
            searchcell.courseTitle.text = "test"
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.table.hidden = true
        self.searchResult.hidden = false
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.table.hidden = true
        self.searchResult.hidden = false
    }
}