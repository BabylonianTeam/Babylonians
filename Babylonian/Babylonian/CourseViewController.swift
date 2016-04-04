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

class CourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVAudioRecorderDelegate {

    var currentCourse: BBCourse!
    var currentCourseItem: CourseItem!
    //var courseItems = [CourseItem]()
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
//    var audioPlayer = AVAudioPlayer()
    var audioURL = NSURL()
    
    @IBOutlet weak var courseTableView: LPRTableView!
    
    @IBOutlet weak var tableEditButton: UIButton!
    //TODO: initwithCourseId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(CourseViewController.backTapped))
        
        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
        self.courseTableView.longPressReorderEnabled = false
        
        if let _=(self.navigationController as! BBCourseNavController).currentCourse {
            //has a value already
            print("currentCourse has a value already")
            
        }
        else{
            //let ref = DataService.dataService.COURSE_REF.childByAutoId()
            //uncomment above and comment below to actually create new course.
            let ref = DataService.dataService.COURSE_REF.childByAppendingPath("/-KEPJobHpCZ1z_4xOI6C")
            (self.navigationController as! BBCourseNavController).currentCourse = BBCourse(ref: ref, author: NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String)
        }
        self.currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
        
        self.currentCourse.firebaseRef.observeEventType(.Value, withBlock: { snapshot in
            
            if let content = snapshot.value.objectForKey("content"){
                
                for item in content as! [String:NSDictionary]{
                    if let im_ref = item.1[COURSE_ITEM_IMAGE] {
                        let courseItem = ImageItem(courseImage: im_ref as! String,order: item.1[COURSE_ITEM_ORDER] as! Int)
                        self.currentCourse.addCourseItem(courseItem)
                        
                    }
                    else if let text_ref = item.1[COURSE_ITEM_TEXT]  {
                        let courseItem = ATItem(courseText: text_ref as! String, courseAudio: item.1[COURSE_ITEM_AUDIO] as! String, order: item.1[COURSE_ITEM_ORDER] as! Int)
                        self.currentCourse.addCourseItem(courseItem)
                    }
                }
                self.courseTableView.reloadData()
            }
            else{
                //course without content
                
            }
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
        //prepare for recording
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
        
        if self.courseTableView.editing {
            self.courseTableView.setEditing(false, animated: true)
            self.tableEditButton.setTitle("Edit", forState: .Normal)
        }
        else{
            self.courseTableView.setEditing(true, animated: true)
            self.tableEditButton.setTitle("Done", forState: .Normal)
        }
        
    }

    @IBAction func nextButton(sender: UIButton) {
        //TODO: check item number
        //TODO: Push to the next view
    }
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        startRecording()
    }
    
    @IBAction func recordButtonReleased(sender: UIButton) {
        finishRecording(success: true)
        //self.currentCourseItem.addVoice(url)
    }
    
    
    
    func startRecording() {
        let audioFilename = DataService.dataService.LOCAL_DIR+"/recording.m4a"
        self.audioURL = NSURL(fileURLWithPath: audioFilename)
        print(audioFilename)
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
    
//    @IBAction func testplay(sender: UIButton) {
//        do{
//            self.audioPlayer = try AVAudioPlayer(contentsOfURL:self.audioURL, fileTypeHint:nil)
//            self.audioPlayer.prepareToPlay()
//            self.audioPlayer.play()
//        }catch {
//            print("Error getting the audio file")
//        }
//        
 //   }
    
    func finishRecording(success success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentCourse.contents.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   
        if self.currentCourse.contents[indexPath.row].getType()==COURSE_ITEM_TYPE_AUDIOTEXT {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("ATItemCell", forIndexPath: indexPath) as! ATItemCell
            let dic = self.currentCourse.contents[indexPath.row].content as! [String:String]
            cell1.transcript.text = dic[COURSE_ITEM_TEXT]
            cell1.audioUrl = NSURL(fileURLWithPath: dic[COURSE_ITEM_AUDIO]!)
            return cell1

        }
        else {
            
            let cell2 = tableView.dequeueReusableCellWithIdentifier("ImageItemCell", forIndexPath: indexPath) as! ImageItemCell
            let dic = self.currentCourse.contents[indexPath.row].content as! [String:String]
            
            if let stringUrl = dic[COURSE_ITEM_IMAGE] {
                if let url = NSURL(string: stringUrl) {
                    if let data = NSData(contentsOfURL: url) {
                        cell2.imageView?.image = UIImage(data: data)
                    }
                }
            }
            return cell2
        }
        
                
    }
    
    //Long-press reordering can be disabled entirely by setting a Bool to lprTableView.longPressReorderEnabled
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // Modify this code as needed to support more advanced reordering, such as between sections.
        let source = self.currentCourse.contents[sourceIndexPath.row]
        let destination = self.currentCourse.contents[destinationIndexPath.row]
        //self.currentCourse.contents[sourceIndexPath.row] = destination
        //self.currentCourse.contents[destinationIndexPath.row] = source
        //TODO: reorder
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backTapped() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
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
