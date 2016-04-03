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

    var courseItems = [CourseItem]()
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var courseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(CourseViewController.backTapped))
        
        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
        
        let course_url = DataService.dataService.COURSE_REF.childByAppendingPath("/-KEPJobHpCZ1z_4xOI6C")
        
        course_url.observeEventType(.Value, withBlock: { snapshot in
            
            let content = snapshot.value.objectForKey("content") as! [String:NSDictionary]
            for item in content{
                if let im_ref = item.1[COURSE_ITEM_IMAGE] {
                    let courseItem = ImageItem(courseImage: im_ref as! String,order: item.1[COURSE_ITEM_ORDER] as! Int)
                    self.courseItems.append(courseItem)
                    
                }
                else if let text_ref = item.1[COURSE_ITEM_TEXT]  {
                    let courseItem = ATItem(courseText: text_ref as! String, courseAudio: item.1[COURSE_ITEM_AUDIO] as! String, order: item.1[COURSE_ITEM_ORDER] as! Int)
                    self.courseItems.append(courseItem)
                }
                
            }
            print(self.courseItems)
            
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
    }
    
    
    
    func startRecording() {
        let audioFilename = DataService.dataService.LOCAL_DIR+"/recording.m4a"
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
    
    func finishRecording(success success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numberOfRowsInSection")
        return self.courseItems.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        
        if self.courseItems[indexPath.row].getType()==COURSE_ITEM_TYPE_AUDIOTEXT {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("ATItemCell", forIndexPath: indexPath) as! ATItemCell
            let dic = self.courseItems[indexPath.row].content as! [String:String]
            cell1.transcript.text = dic[COURSE_ITEM_TEXT]
            cell1.audioPath = dic[COURSE_ITEM_AUDIO]
            return cell1

        }
        else {
            
            let cell2 = tableView.dequeueReusableCellWithIdentifier("ImageItemCell", forIndexPath: indexPath) as! ImageItemCell
            let dic = self.courseItems[indexPath.row].content as! [String:String]
            cell2.imageView?.image = UIImage(contentsOfFile: dic[COURSE_ITEM_IMAGE]!)
            return cell2
        }
        
                
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
