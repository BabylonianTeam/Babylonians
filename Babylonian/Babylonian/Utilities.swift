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

func getCurrentDate() -> String{
    let date = NSDate()
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day , .Month , .Year], fromDate: date)
    let year =  components.year
    let month = components.month
    let day = components.day
    let currDate = String(month) + "-" + String(day) + "-" + String(year);
    return currDate
}

func getCurrentDateTime() -> String{
    let df = NSDateFormatter()
    df.dateFormat = USER_DATETIME_FORMAT
    
    return df.stringFromDate(NSDate())
}