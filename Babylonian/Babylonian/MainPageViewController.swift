//
//  MainPageViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 3/17/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit

class MainPageViewController: UITableViewController, UISearchResultsUpdating{
    var testData = ["course1","course2","course3",
        "course4","course5"]
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
        
        
        //self.searchDisplayController.
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    override func viewDidAppear(animated: Bool) {

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0{
            return "Popular Courses"
        }
        else {
            return "Trending Courses"
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (self.resultSearchController.active) {
            return self.filteredTableData.count
        }
        else {
            return testData.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("MainCourseCell", forIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("MainCourseCell", forIndexPath: indexPath) as! MainCourseCell

        // Configure the cell...
        if (self.resultSearchController.active) {
            cell.title.text = filteredTableData[indexPath.row]
            cell.numOfView.text = "10"
            return cell
        }
        else {
            cell.title?.text = testData[indexPath.row]
            cell.numOfView.text = "1k"
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (testData as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }

}
