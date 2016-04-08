//
//  MainPageViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 3/17/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    var courseLists = [[BBCourse](),[BBCourse]()]
    var allCourseTitles = [String]()
    var filtered = [String]()
    var searchActive : Bool = false
    let sections = ["Popular", "Trending"]
    var initialized = false
    
    @IBOutlet weak var searchResult: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    override func viewWillAppear(animated: Bool) {
        table.reloadData()
    }
    override func viewDidLoad() {
        
        self.navigationController?.navigationBarHidden = true
        table.delegate = self
        table.dataSource = self
        
        searchResult.dataSource = self
        searchResult.delegate = self
        searchBar.delegate = self
        
        self.searchResult.hidden = true
        table.reloadData()
        loadTopCourses()
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false

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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
    
    //    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 10
    //    }
    
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
            bbCourseController.currentCourse = self.courseLists[indexPath.section][indexPath.row]
        }
        self.presentViewController(bbCourseController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView==self.searchResult {
            let searchcell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! SearchCell
            searchcell.courseTitle.text = filtered[indexPath.row].componentsSeparatedByString("|")[1]
            return searchcell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MainCourseCell", forIndexPath: indexPath) as! MainCourseCell
        
        if let t = self.courseLists[indexPath.section][indexPath.row].title{
            cell.title.text = t
        }
        
        if let t = self.courseLists[indexPath.section][indexPath.row].title{
            cell.title.text = t
        }
        else {
            cell.title.text="null"
        }
        
        
        //Will probably have to convert some value here to a view count
        cell.numOfView.text = "55 views"
        
        return cell
    }
    
    /*
     * Paramaters: None
     * Connect to Firebase database and pull myCourses data belonging to each user. Since we are using Firebase we don't have to worry about active
     * record!
     */
    
    func loadTopCourses(){
        //TODO Create a test with/ a for loop that hooks in to the database model
        self.initialized = false
        ProgressHUD.show("Loading Courses")
        
        
        DataService.dataService.COURSE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            if self.initialized {
                
                let c = BBCourse(ref: snapshot.ref)
                if let t = snapshot.value.objectForKey(COURSE_TITLE) {
                    c.setTitle(t as! String)
                    self.allCourseTitles.append(snapshot.key+"|"+c.title!)
                }
                if let st = snapshot.value.objectForKey(COURSE_STATUS) {
                    if  st as! String == COURSE_STATUS_ONSHELF{
                        self.courseLists[0].append(c)
                    }
                    else{
                        self.courseLists[1].append(c)
                    }
                }
                else {
                    c.setStatus(COURSE_STATUS_DRAFT)
                    self.courseLists[1].append(c)
                }
                
            }
        })
        
        DataService.dataService.COURSE_REF.observeEventType(.ChildAdded, withBlock: { snapshot in
            if self.initialized {
                
                let c = BBCourse(ref: snapshot.ref)
                if let t = snapshot.value.objectForKey(COURSE_TITLE) {
                    c.setTitle(t as! String)
                    self.allCourseTitles.append(snapshot.key+"|"+c.title!)
                }
                if snapshot.value.objectForKey(COURSE_STATUS) as! String == COURSE_STATUS_ONSHELF{
                    self.courseLists[0].append(c)
                }
                else{
                    self.courseLists[1].append(c)
                }
                
            }
        })
        
        DataService.dataService.COURSE_REF.observeEventType(.Value, withBlock: { snapshot in
            
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
                                self.courseLists[0].append(c)
                            }
                            else{
                                self.courseLists[1].append(c)
                            }
                        }
//                        if let prev = cData[COURSE_PREVIEW] {
//                            if st as! String==COURSE_STATUS_ONSHELF {
//                                self.courseLists[0].append(c)
//                            }
//                            else{
//                                self.courseLists[1].append(c)
//                            }
//                        }
                        
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
