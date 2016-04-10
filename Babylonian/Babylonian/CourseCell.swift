//
//  CourseCell.swift
//  Babylonian
//
//  Modified by Dongning Wang
//  Created by Eric Smith on 3/14/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation
import UIKit

class CourseCell : UITableViewCell{
    
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var profitAmount: UILabel!
    @IBOutlet weak var courseViewCount: UILabel!
    @IBOutlet weak var profitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let bigFont = UIFont(name: FONT_BIG, size: CGFloat(FONT_SIZE))
        let smallFont = UIFont(name: FONT_SMALL, size: CGFloat(FONT_SIZE))
        
        let primaryColor = UIColor.blackColor()
        let secondaryColor = UIColor.lightGrayColor()
    
        courseTitle.font = bigFont
        courseTitle.textColor = primaryColor
        
        
        profitAmount.font = smallFont
        profitAmount.textColor = secondaryColor
        profitLabel.font = smallFont
        profitLabel.textColor = secondaryColor
        courseViewCount.font = smallFont
        courseViewCount.textColor = secondaryColor
        
        
        if detailTextLabel != nil {
            detailTextLabel?.font = smallFont
            detailTextLabel?.textColor = secondaryColor
        }
        

    }
}