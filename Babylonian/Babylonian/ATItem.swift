 //
//  ATItem.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/2/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import Foundation
import Firebase

class ATItem: CourseItem {
    init(ref: Firebase, courseText: String, courseAudio: String, order: Int, duration:Float) {//, courseText: NSObject
        super.init(ref: ref, order:order)
        self.content = [COURSE_ITEM_TEXT:courseText,COURSE_ITEM_AUDIO:courseAudio,COURSE_ITEM_AUDIO_DURATION:duration]
    }
    
    override func getType() -> String {
        return COURSE_ITEM_TYPE_AUDIOTEXT
    }
    
    func setText(text:String!) {
        self.content.setValue(text, forKey: COURSE_ITEM_TEXT)
        self.itemRef.updateChildValues([COURSE_ITEM_TEXT:text])
    }
    
    func setAudio(audioUrl:String!) {
        self.content.setValue(audioUrl, forKey: COURSE_ITEM_AUDIO)
        self.itemRef.updateChildValues([COURSE_ITEM_AUDIO:audioUrl])
    }
    
    func setAudioDuration(duration:Float!) {
        self.content.setValue(duration, forKey: COURSE_ITEM_AUDIO_DURATION)
        self.itemRef.updateChildValues([COURSE_ITEM_AUDIO_DURATION:duration])
    }
    
    override func toAnyObject() -> AnyObject {
        
        return [
            COURSE_ITEM_AUDIO: self.content[COURSE_ITEM_AUDIO] as! String,
            COURSE_ITEM_TEXT: self.content[COURSE_ITEM_TEXT] as! String,
            COURSE_ITEM_ORDER: order,
            COURSE_ITEM_AUDIO_DURATION: self.content[COURSE_ITEM_AUDIO_DURATION] as! Float
        ]
    }

    
    
}