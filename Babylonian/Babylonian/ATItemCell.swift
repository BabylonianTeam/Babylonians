//
//  ATItemCell.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit
import AVFoundation

class ATItemCell: UITableViewCell, UITextViewDelegate {

    //var audioUrl : NSURL!
    var item : ATItem!
    
    @IBOutlet weak var playButton: PlaybackButton!
    @IBOutlet weak var transcript: UITextView!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        transcript.delegate = self
        
        
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
 
    
    @IBAction func throughAudio(sender: PlaybackButton) {
        //TODO remove audio
    }
    
    
    @IBAction func playButtonPressed(sender: UIButton) {
        let audioPlayer = STKAudioPlayer()
        
        if self.playButton.buttonState == .Playing {
            self.playButton.setButtonState(.Pausing, animated: true)
            audioPlayer.stop()
        } else if self.playButton.buttonState == .Pausing {
            audioPlayer.play(self.item.content[COURSE_ITEM_AUDIO] as! String)
            self.playButton.setButtonState(.Playing, animated: true)
        }
    }
    
    func refreshText() -> Void {
        if let contents = self.item.content {
            transcript.text = contents[COURSE_ITEM_TEXT] as! String
        }
    }

    //TODO: tap and drag//tap and hold to record
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            self.item.setText(self.transcript.text)
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
