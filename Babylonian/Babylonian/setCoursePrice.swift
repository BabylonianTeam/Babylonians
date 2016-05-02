//
//  setCoursePrice.swift
//  Babylonian
//
//  Created by Jiqing Xu on 5/2/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit

class setCoursePrice: UITableViewCell, UITextFieldDelegate  {
    
    var currentCourse:BBCourse!
    
    @IBOutlet weak var price: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        price.delegate = self
        // Initialization code
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        currentCourse.setPrice((price as? NSNumber as? Float)!)
//        textField.resignFirstResponder()
//        return true
//    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
