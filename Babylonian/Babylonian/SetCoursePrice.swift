//
//  SetCoursePrice.swift
//  Babylonian
//
//  Created by Jiqing Xu on 5/2/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit

class SetCoursePrice: UITableViewCell,UITextFieldDelegate {

   
    
    
    
    var currentCourse:BBCourse!
    
    @IBOutlet weak var price: UITextField!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         price.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
