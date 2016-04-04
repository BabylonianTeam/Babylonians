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
    
    init(ref: Firebase, courseText: String, courseAudio: String, order: Int) {//, courseText: NSObject
        super.init(ref: ref, order:order)
        self.content = [COURSE_ITEM_TEXT:courseText,COURSE_ITEM_AUDIO:courseAudio]
    }
    
    override func getType() -> String {
        return COURSE_ITEM_TYPE_AUDIOTEXT
    }
    
    func setText(text:String!) {
        self.content.setValue(text, forKey: COURSE_ITEM_TEXT)
    }
    
    func setAudio(audioUrl:String!) {
        self.content.setValue(audioUrl, forKey: COURSE_ITEM_AUDIO)
    }
    
    override func toAnyObject() -> AnyObject {
        
        return [
            
            COURSE_ITEM_AUDIO: self.content[COURSE_ITEM_AUDIO] as! String,
            COURSE_ITEM_TEXT: self.content[COURSE_ITEM_TEXT] as! String,
            COURSE_ITEM_ORDER: order
        ]
    }

    
    
}