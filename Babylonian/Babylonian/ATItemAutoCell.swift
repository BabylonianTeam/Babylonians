//
//  ATItemAutoCell.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/9/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit

class ATItemAutoCell: UITableViewCell, UITextViewDelegate {
    
    var item : ATItem!
    var timer = NSTimer()
    var textLineNum = 1
    
    
    
    @IBOutlet weak var transcript: UITextView!
    @IBOutlet weak var playButton: PlaybackButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        transcript.delegate = self
        
        transcript.textContainer.maximumNumberOfLines = 5;
        transcript.textContainer.lineBreakMode = NSLineBreakMode.ByWordWrapping;

        self.playButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.playButton.layer.cornerRadius = self.playButton.frame.size.height/2
        self.playButton.layer.borderColor = self.playButton.tintColor.CGColor
        self.playButton.layer.borderWidth = 1.0
        if let _ = self.item {
            if let contents = self.item.content {
                self.playButton.duration = contents[COURSE_ITEM_AUDIO_DURATION] as! Double
            }
        }
        else{
            print("item has no value, it's nil")
        }
        
        
        self.playButton.adjustMargin = 1
        
    }

    
    @IBAction func playButtonPressed(sender: UIButton) {
        let audioPlayer = STKAudioPlayer()
        
        if self.playButton.buttonState == .Playing {
            self.playButton.setButtonState(.Pausing, animated: true)
            print("pausing")
            //audioPlayer.stop()
            audioPlayer.pause()
        } else if self.playButton.buttonState == .Pausing {
            var dur:Float = 2.0
            if let i = self.item {
                if let d = i.duration {
                    dur = d+1
                }
            }
            timer = NSTimer.scheduledTimerWithTimeInterval(Double(dur), target: self, selector: #selector(ATItemAutoCell.stopPlay), userInfo: nil, repeats: false)
            audioPlayer.play(self.item.content[COURSE_ITEM_AUDIO] as! String)
            self.playButton.setButtonState(.Playing, animated: true)
        }
        
    }
    
    func stopPlay() -> Void {
        let audioPlayer = STKAudioPlayer()
        if self.playButton.buttonState == .Playing {
            self.playButton.setButtonState(.Pausing, animated: true)
            audioPlayer.stop()
        }
    }
    
    func refreshText() -> Void {
        if let contents = self.item.content {
            transcript.textColor = UIColor.blackColor()
            transcript.text = contents[COURSE_ITEM_TEXT] as! String
        }
        if (transcript.text ?? "").isEmpty && transcript.editable {
            transcript.text = "Tap here to edit transcript"
            transcript.textColor = UIColor.lightGrayColor()
        }
    }
    
    //TODO: tap and drag//tap and hold to record
    func textViewDidBeginEditing(textView: UITextView) {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "EditingATItem", object: nil, userInfo: ["Cell":self]))
        if transcript.textColor == UIColor.lightGrayColor() {
            transcript.text = ""
            transcript.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if transcript.text.isEmpty {
            transcript.text = "Tap here to edit transcript"
            transcript.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            self.item.setText(self.transcript.text)
            textView.resignFirstResponder()
            return false
        }
        let fixedWidth = textView.frame.size.width
        //textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        //textView.layoutIfNeeded()
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame;
        
        let newLineNum = Int(textView.contentSize.height/(textView.font?.lineHeight)!)
        if newLineNum != textLineNum {
            textLineNum = newLineNum
            self.item.setText(self.transcript.text)
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "RefreshCourseViewTable", object: nil))
        }
        return true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
