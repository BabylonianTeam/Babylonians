//
//  SetCourseTitle.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/19/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit

class SetCourseTitle: UITableViewCell, UITextFieldDelegate {
    
    var currentCourse:BBCourse!
    @IBOutlet weak var title: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        title.delegate = self
        // Initialization code
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        currentCourse.setTitle(title.text!)
        textField.resignFirstResponder()
        return true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
