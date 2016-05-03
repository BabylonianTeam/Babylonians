//
//  TagViewCell.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/19/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//
import TagListView
import UIKit

class TagViewCell: UITableViewCell, UITextFieldDelegate {
    
    var currentCourse:BBCourse?
    //var tagArray = [String]()

    
    @IBOutlet weak var tagListView: TagListView!

    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.tagListView.textFont = UIFont.systemFontOfSize(24)
        textField.delegate = self
 
        
        self.tagListView.alignment = .Left // possible values are .Left, .Center, and .Right
    }
    
    func refreshTags() -> Void {
        if let _ = currentCourse {
            if currentCourse!.tag.count>0 {
                for tag in currentCourse!.tag {
                    self.tagListView.addTag(tag)
                }
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func clearAllTags(sender: UIButton) {
        self.currentCourse!.removeAllTags()
        self.tagListView.removeAllTags()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addTag(textField.text!)
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    func addTag(newtag:String) -> Void {
       
        let t = newtag.trim()
        
        if t.characters.count>0 {
            if self.currentCourse!.addTag(t) {
                self.tagListView.addTag(t)
            }
        }
        print(self.currentCourse?.tag)
    }
    
}
