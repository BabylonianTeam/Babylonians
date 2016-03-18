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
    //Need to hold a fake db for "Title, Text, and Profit"
    
    //Temporary Value for Testing. Safe to remove once Table Model is implemented
    var course1 = CourseCell();
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        table.reloadData()
    }
    override func viewDidLoad() {
        
        table.delegate = self;
        table.dataSource = self;
        table.rowHeight = 90;
        
        table.reloadData()
        loadMyCourses();
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
    
    /*
    * Paramaters: None
    * Connect to Firebase database and pull myCourses data belonging to each user. Since we are using Firebase we don't have to worry about active
    * record!
    */
    func loadMyCourses(){
        //TODO Create a test with/ a for loop that hooks in to the database model
        print(course1);
        course1.courseTitle?.text = "Beautiful Cuts Hair Salon"
        course1.courseViewCount?.text = "55"
        course1.profitAmount?.text = "$500"
        
        courses += [course1]
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CourseCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CourseCell
        print(courses.count);
        if(courses.count != 0){
            
            let course = courses[indexPath.row];
            print(course.courseTitle?.text)
            //Create a unit test for these values
            cell.courseTitle.text = "Beautiful Cuts Hair Salon";
            //Will probably have to convert some value here to a view count
            cell.courseViewCount.text = "55"
            cell.profitAmount.text = "$500"
        }
        
        
        
        return cell
    }
}