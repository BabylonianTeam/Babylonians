//
//  BabylonianTests.swift
//  BabylonianTests
//
//  Created by Eric Smith on 3/6/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import XCTest
@testable import Babylonian

class BabylonianTests: XCTestCase {
    var testBBCourse : BBCourse! = nil
    var testBBCourse2 : BBCourse! = nil
    weak var expectation:XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("/-KEPJobHpCZ1z_4xOI6C")
        testBBCourse = BBCourse(ref: ref)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testWriters() {
//        
//        
//        for _ in 1...3 {
//            let newref = DataService.dataService.COURSE_REF.childByAutoId()
//            testBBCourse2 = BBCourse(ref:newref)
//            _ = self.keyValueObservingExpectationForObject(testBBCourse2, keyPath: "status", expectedValue: COURSE_STATUS_ONSHELF)
//            testBBCourse2.addNewImageItem("http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/74d213665211cddfdfaaa85cb4b8c657_image.jpg")
//            testBBCourse2.addNewATItem("item1", courseAudio: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/5ce7574bbba01cc794551ab4ecbbce5d_audio.m4a", duration: 1)
//            testBBCourse2.addNewATItem("item2", courseAudio: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/5ce7574bbba01cc794551ab4ecbbce5d_audio.m4a", duration: 1)
//            testBBCourse2.addNewATItem("item3", courseAudio: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/5ce7574bbba01cc794551ab4ecbbce5d_audio.m4a", duration: 1)
//            testBBCourse2.addNewATItem("item4", courseAudio: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/5ce7574bbba01cc794551ab4ecbbce5d_audio.m4a", duration: 1)
//            testBBCourse2.setTitle("A fake course")
//            let newItem = ImageItem(ref: testBBCourse2.contentRef.childByAutoId(), courseImage: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/74d213665211cddfdfaaa85cb4b8c657_image.jpg", order: 5)
//            testBBCourse2.addCourseItem(newItem)
//            testBBCourse2.setAuthor("1e6100ee-c30f-4945-845d-658648beb102")
//            testBBCourse2.setStatus(COURSE_STATUS_DRAFT)
//            testBBCourse2.moveItemTo(6, to: 3)
//        }
//        for _ in 1...3 {
//            let newref = DataService.dataService.COURSE_REF.childByAutoId()
//
//            testBBCourse2 = BBCourse(ref:newref)
//            testBBCourse2.addNewImageItem("http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/74d213665211cddfdfaaa85cb4b8c657_image.jpg")
//            testBBCourse2.addNewATItem("item1", courseAudio: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/5ce7574bbba01cc794551ab4ecbbce5d_audio.m4a", duration: 1)
//            testBBCourse2.addNewATItem("item2", courseAudio: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/5ce7574bbba01cc794551ab4ecbbce5d_audio.m4a", duration: 1)
//            testBBCourse2.addNewATItem("item3", courseAudio: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/5ce7574bbba01cc794551ab4ecbbce5d_audio.m4a", duration: 1)
//            testBBCourse2.addNewATItem("item4", courseAudio: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/5ce7574bbba01cc794551ab4ecbbce5d_audio.m4a", duration: 1)
//            testBBCourse2.setTitle("A fake course")
//            let newItem = ImageItem(ref: testBBCourse2.contentRef.childByAutoId(), courseImage: "http://parseserver-2nwux-env.us-west-2.elasticbeanstalk.com/parse/files/iZBQhKLvStLDiflpBDUy1NTMhfa6I8aHNa35J0Cz/74d213665211cddfdfaaa85cb4b8c657_image.jpg", order: 5)
//            testBBCourse2.addCourseItem(newItem)
//            testBBCourse2.setAuthor("1e6100ee-c30f-4945-845d-658648beb102")
//            testBBCourse2.setStatus(COURSE_STATUS_ONSHELF)
//            testBBCourse2.moveItemTo(6, to: 3)
//        }
//         waitForExpectationsWithTimeout(50, handler: nil)
//    }
//    
//    func testChangeStatus()  {
//        //change status test
//        expectation = self.expectationWithDescription("asynchronous request")
//        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("-KEcvUWthBmKalnyep3y")
//        let testBBCourse3 = BBCourse(ref: ref)
//        testBBCourse3.setStatus(COURSE_STATUS_DRAFT)
//        testBBCourse3.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
//            if let value = snapshot.value {
//                assert(value[COURSE_STATUS]==COURSE_STATUS_DRAFT)
//                self.expectation?.fulfill()
//            }
//            
//        })
//         self.waitForExpectationsWithTimeout(10.0, handler:nil)
//    }
    
    
    func testSetTag()  {
        //change coursetag
        expectation = self.expectationWithDescription("asynchronous request")
    
        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("-KEcvUWthBmKalnyep3y")
        let testBBCourse4 = BBCourse(ref: ref)
        let tagArray = ["happy", "sad"]
        let tagArrayTransfer = "happy|sad"
        testBBCourse4.setTag(tagArray)
        testBBCourse4.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            if let value = snapshot.value {
                assert(value[COURSE_TAG]==tagArrayTransfer)
                self.expectation?.fulfill()
            }
            
        })
        self.waitForExpectationsWithTimeout(10.0, handler:nil)
        
    }
    func didReceiveWhatever(thing:String) {
        expectation?.fulfill()
    }

    
    func testSetPrice()  {
        //change courseprice
        expectation = self.expectationWithDescription("asynchronous request")
        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("-KEcvUWthBmKalnyep3y")
        let testBBCourse4 = BBCourse(ref: ref)
        var price: Float?
        price = 3.9
        testBBCourse4.setPrice(price!)
        testBBCourse4.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            if let value = snapshot.value {
                assert(value[COURSE_PRICE]==price)
                self.expectation?.fulfill()
            }
            
        })
        self.waitForExpectationsWithTimeout(10.0, handler:nil)
    }
    
    
    func testSetTitle()  {
        
        expectation = self.expectationWithDescription("asynchronous request")
        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("-KEcvUWthBmKalnyep3y")
        let testBBCourse4 = BBCourse(ref: ref)
        var title: String?
        title = "test for add title"
        testBBCourse4.setTitle(title!)
        testBBCourse4.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            
            if let value = snapshot.value {
                print(value)
                assert(value[COURSE_TITLE]==title)
                self.expectation?.fulfill()
            }
        })
        self.waitForExpectationsWithTimeout(10.0, handler:nil)
    }
    
    
    func testSetAuthor()  {
        
        expectation = self.expectationWithDescription("asynchronous request")
        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("-KEcvUWthBmKalnyep3y")
        let testBBCourse4 = BBCourse(ref: ref)
        var author: String?
         author = "author"
        testBBCourse4.setAuthor(author!)
        testBBCourse4.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            
            if let value = snapshot.value {
                print(value)
                assert(value[COURSE_AUTHOR]==author)
                self.expectation?.fulfill()
            }
        })
        self.waitForExpectationsWithTimeout(10.0, handler:nil)
    }
    
    
    
    func testSetStatus()  {
        
        expectation = self.expectationWithDescription("asynchronous request")
        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("-KEcvUWthBmKalnyep3y")
        let testBBCourse4 = BBCourse(ref: ref)
        var status: String?
        status = "author"
        testBBCourse4.setStatus(status!)
        testBBCourse4.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            
            if let value = snapshot.value {
                print(value)
                assert(value[COURSE_STATUS]==status)
                self.expectation?.fulfill()
            }
        })
        self.waitForExpectationsWithTimeout(10.0, handler:nil)
    }

    
    func testaddATItem()  {
        expectation = self.expectationWithDescription("asynchronous request")
        let ref = DataService.dataService.COURSE_REF.childByAppendingPath("-KEcvUWthBmKalnyep3y")
        let testBBCourse4 = BBCourse(ref: ref)
        //let newAt = ATItem(ref: ref, courseText: "newText", courseAudio: "newAudio",order: 1, duration: 1)
        testBBCourse4.addNewATItem("newText", courseAudio: "newAudio", duration: 1)
        
        testBBCourse4.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            
            if let data = snapshot.value {
                print(data)
                 for (key,value) in data as! [String:AnyObject]{
                    print(value)
                    if key == "content" {
                        for (key,valuee) in value as! [String:AnyObject]{
                            if key == "-KEnaMNpmI-Z7WIxzokD"{
                         print(valuee)
                    
                            assert(valuee[COURSE_ITEM_ORDER]==1)
                           assert(valuee[COURSE_ITEM_AUDIO]=="newAudio")
                            assert(valuee[COURSE_ITEM_TEXT]=="newText")
                            assert(valuee[COURSE_ITEM_AUDIO_DURATION]==1)
                            self.expectation?.fulfill()
                            self.expectation = nil
                            }
                        }
        
                    }else{
                        print("not go through")
                    }
                }
            }
        
            })
        self.waitForExpectationsWithTimeout(10.0, handler:nil)
    }

    
    
//    func testReadAllCourse(){
//        let ref = DataService.dataService.COURSE_REF
//        let expectation = self.expectationWithDescription("data read")
//        
//        ref.observeSingleEventOfType(.Value, withBlock: {snapshot in
//            print(snapshot)
//            if let data = snapshot.value {
//                print("been there")
//                for (key,value) in data as! [String:AnyObject]{
//                    let b = BBCourse(ref: ref.childByAppendingPath(key))
//                    if let _ = (value as! [String:AnyObject])[COURSE_AUTHOR]{
//                        //
//                    }else{
//                        b.deleteBBCourse()
//                    }
//                    
//                    let r = random()
//                    
//                    if value[COURSE_TITLE]==nil && value[COURSE_CONTENT]==nil {
//                        b.deleteBBCourse()
//                    }
//                    if r%3==0 {
//                        //do something
//                        b.courseRef.updateChildValues([COURSE_STATUS:COURSE_STATUS_ONSHELF])
//                    }else if r%3==1{
//                        //do something
//                        b.courseRef.updateChildValues([COURSE_STATUS:COURSE_STATUS_ARCHIVED])
//                    }else {
//                        b.courseRef.updateChildValues([COURSE_STATUS:COURSE_STATUS_DRAFT])
//                    }
//                    
//                
//                }
//                expectation.fulfill()
//            }
//        
//        })
//        self.waitForExpectationsWithTimeout(300, handler:nil)
//    }
    
    
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        testBBCourse.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
//            if let course = snapshot.value {
//                for (key, value) in course as! [String:AnyObject]{
//                    
//                    switch key {
//                    case COURSE_CONTENT:
//                        for item in value as! [String:NSDictionary]{
//                            let item_ref = self.testBBCourse.contentRef.childByAppendingPath(item.0)
//                            if let im_ref = item.1[COURSE_ITEM_IMAGE] {
//                                
//                                let courseItem = ImageItem(ref: item_ref, courseImage: im_ref as! String,order: item.1[COURSE_ITEM_ORDER] as! Int)
//                                self.testBBCourse.addCourseItem(courseItem)
//                                
//                            }
//                            else if let text_ref = item.1[COURSE_ITEM_TEXT]  {
//                                let courseItem = ATItem(ref: item_ref,courseText: text_ref as! String, courseAudio: item.1[COURSE_ITEM_AUDIO] as! String, order: item.1[COURSE_ITEM_ORDER] as! Int, duration: item.1[COURSE_ITEM_AUDIO_DURATION] as! Float)
//                                self.testBBCourse.addCourseItem(courseItem)
//                            }
//                        }
//                    case COURSE_AUTHOR:
//                        self.testBBCourse.setAuthor( value as! String)
//                    case COURSE_TITLE:
//                        self.testBBCourse.setTitle(value as! String)
//                    case COURSE_PRICE:
//                        self.testBBCourse.setPrice(value as! Float)
//                    case COURSE_TAG:
//                        self.testBBCourse.setTag(value as! [String])
//                    case COURSE_NUM_SOLD:
//                        self.testBBCourse.purchased_counter_ = value as? Int
//                    default:
//                        assertionFailure("forgot key: "+key)
//                    }
//                    //assert(self.testBBCourse.title!.containsString("title"), "Pass")
//                }
//                
//                self.testBBCourse.sortContentsByOrder()
//                var i = 0
//                for item in self.testBBCourse.contents{
//                    i = i + 1
//                    assert(item.order==i, "Pass")
//                }
//            }
//        })
//        
//        testBBCourse2.courseRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
//            
//            if let content = snapshot.value {
//                for item in content as! [String:NSDictionary]{
//                    let item_ref = self.testBBCourse.contentRef.childByAppendingPath(item.0)
//                    if let im_ref = item.1[COURSE_ITEM_IMAGE] {
//                        
//                        let courseItem = ImageItem(ref: item_ref, courseImage: im_ref as! String,order: item.1[COURSE_ITEM_ORDER] as! Int)
//                        self.testBBCourse.addCourseItem(courseItem)
//                        
//                    }
//                    else if let text_ref = item.1[COURSE_ITEM_TEXT]  {
//                        let courseItem = ATItem(ref: item_ref,courseText: text_ref as! String, courseAudio: item.1[COURSE_ITEM_AUDIO] as! String, order: item.1[COURSE_ITEM_ORDER] as! Int, duration: item.1[COURSE_ITEM_AUDIO_DURATION] as! Float)
//                        self.testBBCourse.addCourseItem(courseItem)
//                    }
//                }
//            }
//            assert((self.testBBCourse2.contents[2].content[COURSE_ITEM_TEXT]?.containsString("4"))!, "pass")
//            
//        })
//        
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
