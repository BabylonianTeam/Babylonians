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
import Parse
import QuartzCore


class CourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVAudioRecorderDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var currentCourse: BBCourse!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioURL = NSURL()
    var imagePicker = UIImagePickerController()
    var initialized: Bool!
    var audioTimer = CACurrentMediaTime()
    
    
    @IBOutlet weak var courseTableView: LPRTableView!
    
    @IBOutlet weak var tableEditButton: UIBarButtonItem!
    //TODO: initwithCourseId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(CourseViewController.backTapped))
        
        self.imagePicker.delegate = self

        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
        self.courseTableView.longPressReorderEnabled = false
        
        //For developing, remove when connected 
        //let ref = DataService.dataService.COURSE_REF.childByAppendingPath("/-KEPJobHpCZ1z_4xOI6C")
        //(self.navigationController as! BBCourseNavController).currentCourse = BBCourse(ref: ref, author: NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String)
        
        
        if let cur_course=(self.navigationController as! BBCourseNavController).currentCourse {
            //has a value already
            print("currentCourse has a value already")
            self.currentCourse = cur_course
        }
        else{
            let ref = DataService.dataService.COURSE_REF.childByAutoId()
            (self.navigationController as! BBCourseNavController).currentCourse = BBCourse(ref: ref, author: NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String)
            self.currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
            self.currentCourse.setTitle("")
        }
        
        self.loadCourse()
        self.prepareRecording()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.currentCourse.contentRef.removeAllObservers()
    }
    
    @IBAction func editButton(sender: UIButton) {
         //TODO: change tableview status
        
        if self.courseTableView.editing {
            self.courseTableView.setEditing(false, animated: true)
            self.tableEditButton.title="Edit"
        }
        else{
            self.courseTableView.setEditing(true, animated: true)
            self.tableEditButton.title="Done"
        }
        
    }

    @IBAction func addImageItem(sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        let data = UIImageJPEGRepresentation(image!, 1)
        let imageFile = PFFile(name: "image.jpg", data: data!)
        
        let pObject = PFObject(className: "Image")
        pObject[PARSE_IMAGE_FILENAME]  = imageFile
        
        //TODO: create a local storage for BBCourse, distinguish from addToLocal and addToRemote
        pObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                self.currentCourse.addNewImageItem((imageFile?.url)!)
                self.courseTableView.reloadData()
                
            }else {
                print(error)
            }
        }
        
    }
    
    @IBAction func nextButton(sender: UIButton) {
        
        if self.currentCourse.contents.count<(Int(COURSE_MIN_ITEMS)){
            ProgressHUD.showError("Course should have at least "+String(COURSE_MIN_ITEMS)+" items")
            //TODO: next view or not?
        }
        //TODO: Push to the next view
    }
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        self.audioTimer = CACurrentMediaTime()
        startRecording()
    }
    
    @IBAction func recordButtonReleased(sender: UIButton) {
        finishRecording(success: true)
        
        let duration = Float(CACurrentMediaTime() - self.audioTimer)
        
        let data = NSData(contentsOfURL: self.audioURL)
        let audioFile = PFFile(name: "audio.m4a", data: data!)
        
        let pObject = PFObject(className: "Audio")
        pObject[PARSE_AUDIO_FILENAME]  = audioFile
        
        pObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                self.currentCourse.addNewATItem("", courseAudio: (audioFile?.url)!, duration:duration)
                self.courseTableView.reloadData()
            }else {
                print(error)
            }
        }
        
    }
    
    func startRecording() {
        let audioFilename = DataService.dataService.LOCAL_DIR+"/recording.m4a"
        self.audioURL = NSURL(fileURLWithPath: audioFilename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(URL: self.audioURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row<self.currentCourse.contents.count && self.currentCourse.contents[indexPath.row].getType()==COURSE_ITEM_TYPE_AUDIOTEXT {
            
            return 40
            
        }
        if indexPath.row<self.currentCourse.contents.count && self.currentCourse.contents[indexPath.row].getType()==COURSE_ITEM_TYPE_IMAGE {
            
            return 100
        }
        return 30
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row<self.currentCourse.contents.count && self.currentCourse.contents[indexPath.row].getType()==COURSE_ITEM_TYPE_AUDIOTEXT {
            let cell = tableView.dequeueReusableCellWithIdentifier("ATItemCell", forIndexPath: indexPath) as! ATItemCell
            cell.item = self.currentCourse.contents[indexPath.row] as! ATItem
            cell.refreshText()
            return cell

        }
        if indexPath.row<self.currentCourse.contents.count && self.currentCourse.contents[indexPath.row].getType()==COURSE_ITEM_TYPE_IMAGE {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageItemCell", forIndexPath: indexPath) as! ImageItemCell
            let dic = self.currentCourse.contents[indexPath.row].content
            
            if let stringUrl = dic[COURSE_ITEM_IMAGE] {
                if let url = NSURL(string: stringUrl as! String) {
                    if let data = NSData(contentsOfURL: url) {
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
            }
            return cell
        }
        
        //if indexPath.row==self.currentCourse.contents.count+1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CreateCourseItemCell", forIndexPath: indexPath) as! CreateCourseItemCell
            
            return cell
        //}
        
                
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.currentCourse.deleteCourseItem(indexPath.row+1)
            self.courseTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    //Long-press reordering can be disabled entirely by setting a Bool to lprTableView.longPressReorderEnabled
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        self.currentCourse.moveItemTo(sourceIndexPath.row+1,to: destinationIndexPath.row+1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backTapped() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadCourse() -> Void {

        
        ProgressHUD.show("Loading Course")
        self.currentCourse.contentRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let content = snapshot.value {
                if !(content is NSNull) {
                    for item in content as! [String:NSDictionary]{
                        let item_ref = self.currentCourse.contentRef.childByAppendingPath(item.0)
                        if let im_ref = item.1[COURSE_ITEM_IMAGE] {
                            
                            let courseItem = ImageItem(ref: item_ref, courseImage: im_ref as! String,order: item.1[COURSE_ITEM_ORDER] as! Int)
                            self.currentCourse.addCourseItem(courseItem)
                            
                        }
                        else if let text_ref = item.1[COURSE_ITEM_TEXT]  {
                            var duration: Float = 1.0
                            if let d = item.1[COURSE_ITEM_AUDIO_DURATION]{
                                duration = d as! Float
                            }
                            let courseItem = ATItem(ref: item_ref,courseText: text_ref as! String, courseAudio: item.1[COURSE_ITEM_AUDIO] as! String, order: item.1[COURSE_ITEM_ORDER] as! Int, duration: duration)
                            self.currentCourse.addCourseItem(courseItem)
                        }
                    }
                    self.currentCourse.sortContentsByOrder()
                    self.courseTableView.reloadData()
                    let indexPath = NSIndexPath(forRow: self.currentCourse.contents.count-1, inSection: 0)
                    self.courseTableView.scrollToRowAtIndexPath(indexPath,
                        atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
                }
            }
            else{
                //course without content
                
            }
            ProgressHUD.dismiss()
            self.initialized = true
        })
        
        
    }
    
    func prepareRecording() -> Void{
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
            print("failed to record!")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
 

}
