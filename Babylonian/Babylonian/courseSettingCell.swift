//
//  courseSettingCell.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/12/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import Foundation


class courseSettingCell: UITableViewCell {
    
    var cellButton: UIButton!
    var cellLabel: UILabel!
    init(frame: CGRect, title: String) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cellLabel = UILabel(frame: CGRectMake(self.frame.width - 100, 10, 100.0, 40))
        cellLabel.textColor = UIColor.blackColor()
        cellLabel.font = //set font here
        
        cellButton = UIButton(frame: CGRectMake(5, 5, 50, 30))
        cellButton.setTitle(title, forState: UIControlState.Normal)
        
        addSubview(cellLabel)
        addSubview(cellButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}
