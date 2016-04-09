//
//  Utilities.swift
//  Babylonian
//
//  Created by Dongning Wang on 3/19/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

//test parse
//        let image = UIImage(named: "aa0f3d544a573d3-1.jpg")
//        let data = UIImageJPEGRepresentation(image!, 1)
//        let imageFile = PFFile(name: "aa0f3d544a573d3-1.jpg", data: data!)
//
//        let testObject = PFObject(className: "Course")
//        testObject[COURSE_TITLE] = "course1"
//        testObject[COURSE_AUTHOR] = "user1"
//        testObject["content"] = imageFile
//
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print(error)
//        }