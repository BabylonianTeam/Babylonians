//
//  MainPageViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 3/17/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    var courseLists = [[GeneralCourseInfo](),[GeneralCourseInfo]()]
    var allCourseTitles = [String]()
    var popularCourseTitles = [String]()
    var filtered = [String]()
    var searchActive : Bool = false
    let sections = ["Popular", "New"]
    var initialized = false
    
    @IBOutlet weak var searchResult: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
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
            return 40
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
        let storyboard = UIStoryboard.init(name: "CoursePreview", bundle: nil)
        let bbCourseController = storyboard.instantiateViewControllerWithIdentifier("BBCourseView") as! BBCourseNavController
        
        
        if tableView==self.searchResult {
            let courseId = filtered[indexPath.row].componentsSeparatedByString("|")[0]
            
            bbCourseController.currentCourse = BBCourse(ref: DataService.dataService.COURSE_REF.childByAppendingPath(courseId))
            
        }
        else {
            bbCourseController.currentCourse = BBCourse(ref: self.courseLists[indexPath.section][indexPath.row].ref)
        }
        bbCourseController.viewOnly = true
        bbCourseController.previewOnly = true
        self.presentViewController(bbCourseController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView==self.searchResult {
            let searchcell = tableView.dequeueReusableCellWithIdentifier("SearchTableCell", forIndexPath: indexPath) as! SearchTableCell
            searchcell.courseTitle.text = filtered[indexPath.row].componentsSeparatedByString("|")[1]
            return searchcell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MainCourseCell", forIndexPath: indexPath) as! MainCourseCell
        
        
        cell.title.text = self.courseLists[indexPath.section][indexPath.row].title
        
        cell.numOfView.text = String(self.courseLists[indexPath.section][indexPath.row].NoV)
        
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
        
        
        DataService.dataService.POPULAR_REF.observeSingleEventOfType(.Value, withBlock: { pop_snapshot in
            
            ProgressHUD.dismiss()
            if let content = pop_snapshot.value {
                
                if !(content is NSNull) {
                    for cId in (content as! [String]) {
                        let cRef = DataService.dataService.COURSE_REF.childByAppendingPath(cId)
                        cRef.observeSingleEventOfType(.Value, withBlock: { course_snapshot in
                            
                            let cData = course_snapshot.value
                            
                            //let c = BBCourse(ref: cref)
                            var title: String!
                            if let t = cData[COURSE_TITLE]{
                                title = t as! String
                            }else{
                                title = "(no title)"
                            }
                            let cInfo = GeneralCourseInfo(ref: cRef, title: title)
                            self.allCourseTitles.append(cId+"|"+title)
                            self.courseLists[0].append(cInfo)
                            
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
        
        
        
        DataService.dataService.TRENDING_REF.observeSingleEventOfType(.Value, withBlock: { trend_snapshot in
            
            ProgressHUD.dismiss()
            if let content = trend_snapshot.value {
                
                if !(content is NSNull) {
                    for cId in (content as! [String]) {
                        let cRef = DataService.dataService.COURSE_REF.childByAppendingPath(cId)
                        cRef.observeSingleEventOfType(.Value, withBlock: { course_snapshot in
                            
                            let cData = course_snapshot.value
                            
                            //let c = BBCourse(ref: cref)
                            var title: String!
                            if let t = cData[COURSE_TITLE]{
                                title = t as! String
                            }else{
                                title = "(no title)"
                            }
                            let cInfo = GeneralCourseInfo(ref: cRef, title: title)
                            self.allCourseTitles.append(cId+"|"+title)
                            self.courseLists[1].append(cInfo)

                            
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
        
    }
}


