//
//  CourseViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class CourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var courseItems = [CourseItem]()
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var courseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(CourseViewController.backTapped))
        
        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
        
        let course_url = DataService.dataService.COURSE_REF.childByAppendingPath("/-KEO4Pbpm3W3RHz9OIKY")
        //course_url.observeSingleEventOfType(.Value, withBlock: <#T##((FDataSnapshot!) -> Void)!##((FDataSnapshot!) -> Void)!##(FDataSnapshot!) -> Void#>)
        
        course_url.observeEventType(.Value, withBlock: { snapshot in
            
            print("printing snapshot")
            print(snapshot.value)
            //for item in snapshot.children {
                //print(item as! FDataSnapshot)
                //let minicourseItem = MinicourseItem(snapshot: item as! FDataSnapshot)
                //self.courseItems.append(minicourseItem)
                // print(newItems)
                
            //}
            
            // print(newItems)
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                        //self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func editButton(sender: UIButton) {
         //TODO: change tableview status
    }

    @IBAction func nextButton(sender: UIButton) {
        //TODO: check item number
        //TODO: Push to the next view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numberOfRowsInSection")
        return self.courseItems.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MainCourseCell", forIndexPath: indexPath) as! MainCourseCell
        
        // Configure the cell...

        cell.title?.text = self.courseItems[indexPath.row].courseId
        cell.numOfView.text = "1k"
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backTapped() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    class func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
