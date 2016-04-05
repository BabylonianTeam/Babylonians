//
//  CourseSettingViewControllerTests.swift
//  Babylonian
//
//  Created by Jiqing Xu on 4/5/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import XCTest
import UIKit
@testable import Babylonian
import CoreData

class CourseSettingViewControllerTests: XCTestCase {
    
    var viewController: CourseSettingViewController!
    
    class MockDataProvider: NSObject {
        
        var managedObjectContext: NSManagedObjectContext?
        func addCourseTitle(sender: UIButton)  { }
        func addCoursePrice(sender: UIButton) { }
        func addCourseTag(sender: UIButton) { }
           }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CourseSettingViewController") as! CourseSettingViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  
    
}
