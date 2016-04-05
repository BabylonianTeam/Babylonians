//
//  ATItemCell.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import UIKit
import AVFoundation

class ATItemCell: UITableViewCell {

    var audioUrl : NSURL!
    
    @IBOutlet weak var playButton: PlaybackButton!
    @IBOutlet weak var transcript: UITextView!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.playButton.layer.cornerRadius = self.playButton.frame.size.height / 2
        print(self.playButton.frame.size.height / 2)
        //self.playButton.layer.borderColor = self.playButton
        self.playButton.layer.borderWidth = 2.0
        self.playButton.duration = 0.3
        //self.playButton.adjustMargin = 1

    }
    
    @IBAction func playButtonPressed(sender: UIButton) {
        let audioPlayer = STKAudioPlayer()
        
        if self.playButton.buttonState == .Playing {
            self.playButton.setButtonState(.Pausing, animated: true)
            audioPlayer.stop()
        } else if self.playButton.buttonState == .Pausing {
            audioPlayer.play(self.audioUrl.absoluteString)
            self.playButton.setButtonState(.Playing, animated: true)
        }
        //TODO: don't play
    }

    //TODO: tap and drag//tap and hold to record
    
    //TODO: change text
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
