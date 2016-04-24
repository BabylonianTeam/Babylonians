//
//  CourseViewController.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/2/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import Parse
import QuartzCore


class CoursePreviewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    var currentCourse: BBCourse!
    
    var initialized: Bool = false
    
    @IBOutlet weak var purchaseButton: UIBarButtonItem!
    

    
    @IBOutlet weak var courseTableView: UITableView!
    
    //TODO: initwithCourseId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(CourseViewController.backTapped))
        

        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
        
        self.courseTableView.rowHeight = UITableViewAutomaticDimension;
        self.courseTableView.estimatedRowHeight = 60.0;
        courseTableView.registerNib(UINib(nibName: "ATItemAutoCell", bundle: nil), forCellReuseIdentifier: "ATItemAutoCell")
        


        if let cur_course=(self.navigationController as! BBCourseNavController).currentCourse {
            //has a value already
            self.currentCourse = cur_course
        }
        else{
            let ref = DataService.dataService.COURSE_REF.childByAutoId()
            (self.navigationController as! BBCourseNavController).currentCourse = BBCourse(ref: ref, author: NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String)
            self.currentCourse = (self.navigationController as! BBCourseNavController).currentCourse
            self.currentCourse.setStatus(COURSE_STATUS_DRAFT)
            self.currentCourse.setTitle("")
        }
        
        if !self.initialized {
            self.loadCourse()
        }
   
        
    }
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.currentCourse.contentRef.removeAllObservers()

    }

    @IBAction func purchaseButtonPressed(sender: UIBarButtonItem) {
        self.purchaseButton.enabled = false
        (self.navigationController as! BBCourseNavController).previewOnly = false
        self.courseTableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isPreviewOnly {
            print(2)
            return 2
        }
        print("been out of 2")
        return self.currentCourse.contents.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row<self.currentCourse.contents.count && self.currentCourse.contents[indexPath.row].getType()==COURSE_ITEM_TYPE_AUDIOTEXT {
            let cell = tableView.dequeueReusableCellWithIdentifier("ATItemAutoCell", forIndexPath: indexPath) as! ATItemAutoCell
            cell.item = self.currentCourse.contents[indexPath.row] as! ATItem
            cell.refreshText()
            //cell.setNeedsUpdateConstraints()
            //cell.updateConstraintsIfNeeded()
           
            return cell

        }
        if indexPath.row<self.currentCourse.contents.count && self.currentCourse.contents[indexPath.row].getType()==COURSE_ITEM_TYPE_IMAGE {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageItemCell", forIndexPath: indexPath) as! ImageItemCell
            let dic = self.currentCourse.contents[indexPath.row].content
            
            if let stringUrl = dic[COURSE_ITEM_IMAGE] {
                if let url = NSURL(string: stringUrl as! String) {
                    cell.imageView?.sd_setImageWithURL(url, placeholderImage: UIImage(named: "default-placeholder.png"))
                }
            }
            cell.imageView?.userInteractionEnabled = true
            cell.imageView?.multipleTouchEnabled = true
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(CourseViewController.imageTapped(_:)))
            tapgesture.delegate = self as? UIGestureRecognizerDelegate
            tapgesture.numberOfTapsRequired = 1
           
            cell.addGestureRecognizer(tapgesture)

            return cell
        }
        
        //if indexPath.row==self.currentCourse.contents.count+1 {
        print("been here")
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageItemCell", forIndexPath: indexPath) as! ImageItemCell
            
        return cell
        //}
        
                
    }
    
    func backTapped() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageTapped(sender: UITapGestureRecognizer) {
        // handling image tapped
        let imageView = (sender.view as! ImageItemCell).imageView
        let newImageView = UIImageView(image: imageView!.image)
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(CourseViewController.dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    var isPreviewOnly : Bool {
        return (self.navigationController as! BBCourseNavController).previewOnly
    }
    
    //content
    func loadCourse() -> Void {
        
        self.initialized = false
        
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
                    
                }
                
            }
            else{
                //course without content
                
            }
            ProgressHUD.dismiss()
            self.initialized = true
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
 

}
