//
//  CreatorMyCoursesViewController.swift
//  Babylonian
//
//  Created by Eric Smith on 3/16/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import UIKit

class CreatorMyCoursesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    var courses = [CourseCell]()
    var course1 = CourseCell();
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        loadMyCourses();
        table.delegate = self;
        table.dataSource = self;
        table.rowHeight = 90;
        table.reloadData()
        print("Working");
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
        return courses.count
    }
    
    func loadMyCourses(){
        courses += [course1]
        //Populate courses form table
    }
    
    //Populates a cells values
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CourseCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CourseCell
        print(courses.count);
        if(courses.count != 0){
            //cell.eventText.text = event.eventTitle
            //cell.startTime.text = event.start_time
            //cell.finishTime.text = event.end_time
            cell.courseTitle.text = "Something Random";
            //Will probably have to convert some value here to a view count
            cell.courseViewCount.text = "55";
            cell.profitAmount.text = "Large Profit";
        }
        
        
        
        return cell
    }
}
