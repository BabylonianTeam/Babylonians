//
//  LearnerTabBarController.swift
//  Babylonian
//
//  Created by Sheng Gan on 5/2/16.
//  Copyright © 2016 BabylonianTeam. All rights reserved.
//

import UIKit


class LearnerTabBarController: UITabBarController {
    var learner: LearnerInfo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        learner = LearnerInfo(id: NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
