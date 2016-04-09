//
//  MainCourseCell.swift
//  Babylonian
//
//  Created by Dongning Wang on 3/17/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation
import UIKit

class MainCourseCell: UITableViewCell {

    var item : ATItem!
    
    @IBOutlet weak var numOfView: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var playButton: PlaybackButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.playButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.playButton.layer.cornerRadius = self.playButton.frame.size.height/2
        self.playButton.layer.borderColor = self.playButton.tintColor.CGColor
        self.playButton.layer.borderWidth = 1.0
        if let _ = self.item {
            if let contents = self.item.content {
                self.playButton.duration = contents[COURSE_ITEM_AUDIO_DURATION] as! Double
            }
        }
        
        
        self.playButton.adjustMargin = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
