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
    var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var transcript: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func playButtonPressed(sender: UIButton) {
        do{
            self.audioPlayer = try AVAudioPlayer(contentsOfURL:self.audioUrl, fileTypeHint:nil)
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
        }catch {
            print("Error getting the audio file")
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
