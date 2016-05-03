//
//  CreatorMyCoursesViewController.swift
//  Babylonian

//  Modified by Dongning
//  Created by Eric Smith on 3/16/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit

class LearnerMyCoursesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    //Need to hold a fake db for "Title, Text, and Profit"
    
    //Temporary Value for Testing. Safe to remove once Table Model is implemented
    
    var courseLists = [MyCourseInfo]()
    //var courseLists = [[MyCourseInfo](),[MyCourseInfo]()]
    var allCourseTitles = [String]()
    var filtered = [String]()
    var searchActive : Bool = false
    //let sections = ["Purchased", "Wishlist"]
    var initialized = false
    
    var currLearner: LearnerInfo!
    
    @IBOutlet weak var searchResult: UITableView!
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewWillAppear(animated: Bool) {
        table.reloadData()
    }
    
    override func viewDidLoad() {
        currLearner = LearnerInfo(id: NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String)
        
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
 
    
    //Setting up tables
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView==self.table {
            return 35
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
        
        return self.courseLists.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard.init(name: "CourseView", bundle: nil)
        let bbCourseController = storyboard.instantiateViewControllerWithIdentifier("BBCourseView") as! BBCourseNavController
        
        if tableView==self.searchResult {
            let courseId = filtered[indexPath.row].componentsSeparatedByString("|")[0]
            
            bbCourseController.currentCourse = BBCourse(ref: DataService.dataService.COURSE_REF.childByAppendingPath(courseId))
            
        }
        else {
            bbCourseController.currentCourse = BBCourse(ref: self.courseLists[indexPath.row].ref)
        }
        bbCourseController.viewOnly = true
        self.presentViewController(bbCourseController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView==self.searchResult {
            let searchcell = tableView.dequeueReusableCellWithIdentifier("SearchTableCell", forIndexPath: indexPath) as! SearchTableCell
            searchcell.courseTitle.text = filtered[indexPath.row].componentsSeparatedByString("|")[1]
            return searchcell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("DraftCell", forIndexPath: indexPath) as! DraftCell
        cell.courseTitle.text = self.courseLists[indexPath.row].title
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
        currLearner.learnerRef.childByAppendingPath(USER_PURCHASED_COURSE).observeEventType(.ChildAdded, withBlock: { snapshot in
            
            if self.initialized {
                let cref = DataService.dataService.COURSE_REF.childByAppendingPath(snapshot.key)
                cref.observeSingleEventOfType(.Value, withBlock: {snap in
                
                    if (snap.value is NSNull){
                        print(snap)
                    }
                    else{
                        var title:String!
                        
                        if let t = snap.value.valueForKey(COURSE_TITLE) {
                            title = t as! String
                        }else {
                            title = "(no title)"
                        }
                        print("**************************")
                        print(title)
                        
                        self.allCourseTitles.append(snap.key+"|"+title)
                        let cInfo = MyCourseInfo(ref: cref, title:title)
                        
                        self.courseLists.append(cInfo)
                    }
                    self.table.reloadData()
                
                
                })
               
                
            }
        })


        currLearner.learnerRef.childByAppendingPath(USER_PURCHASED_COURSE).observeSingleEventOfType(.Value, withBlock: { snapshot in
            ProgressHUD.dismiss()
            if let content = snapshot.value {
                if !(content is NSNull) {
                    for (cId,_) in (content as! [String:NSDictionary]) {
                        let cref = DataService.dataService.COURSE_REF.childByAppendingPath(cId)
                        //print(cref)

                        cref.observeSingleEventOfType(.Value, withBlock: { snapshot1 in
                            if (snapshot1.value is NSNull){
                                print(snapshot1)
                            }
                            else{
                                var title:String!
                                
                                
//                              print("*******************")
                                if let t = snapshot1.value.valueForKey(COURSE_TITLE) {
                                    title = t as! String
                                }else {
                                    title = "(no title)"
                                }
                                print("**************************")
                                print(title)
                                
                                self.allCourseTitles.append(snapshot1.key+"|"+title)
                                let cInfo = MyCourseInfo(ref: cref, title:title)
                                
                                self.courseLists.append(cInfo)
                            }
                            self.table.reloadData()
                        })

                    }
                    
                }
            }
            else{
                //course without content
            }
            self.initialized = true
        })
        
        currLearner.learnerRef.childByAppendingPath(USER_PURCHASED_COURSE).observeEventType(.ChildRemoved, withBlock: { snapshot in
            
            print(snapshot.key)
            var i = 0
            for c in self.courseLists {
                if c.ref.key==snapshot.key {
                    self.courseLists.removeAtIndex(i)
                    self.table.reloadData()
                    break
                }
                i += 1
            }
                
        })
    }
}