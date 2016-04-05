//
//  BBCourseTest.swift
//  Babylonian
//
//  Created by Dongning Wang on 4/5/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import XCTest
@testable import Babylonian

class BBCourseTest: XCTestCase {
    var testBBCourse: BBCourse!
    override func setUp() {
        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("/-KEPJobHpCZ1z_4xOI6C")
        testBBCourse = BBCourse(ref: ref, author: "a long uid")
        
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        self.testBBCourse.deleteCourseItem(4)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
