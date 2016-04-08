//
//  BabylonianUITests.swift
//  BabylonianUITests
//
//  Created by Eric Smith on 3/6/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//


import XCTest
@testable import Babylonian

class BabylonianUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["My Courses"].tap()
        
        let clearTextButton = app.searchFields.buttons["Clear text"]
        clearTextButton.tap()
        
           }
    
    func testExample2() {
        
        
        let app = XCUIApplication()
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        let textField = element.childrenMatchingType(.TextField).elementBoundByIndex(2)
        textField.tap()
        textField.tap()
        app.textFields.containingType(.Button, identifier:"Clear text").element
        
        let addButton = element.childrenMatchingType(.Button).matchingIdentifier("Add").elementBoundByIndex(2)
        addButton.tap()
        
        let clearTextButton = app.buttons["Clear text"]
        clearTextButton.tap()
        app.textFields.containingType(.Button, identifier:"Clear text").element
        addButton.tap()
        clearTextButton.tap()
        app.textFields.containingType(.Button, identifier:"Clear text").element
        addButton.tap()
        
        let clearAllTagButton = app.buttons["Clear All Tag"]
        clearAllTagButton.tap()
        clearTextButton.tap()
        
        let textField2 = element.childrenMatchingType(.TextField).elementBoundByIndex(1)
        textField2.tap()
        textField2.tap()
        app.textFields.containingType(.Button, identifier:"Clear text").element
        element.childrenMatchingType(.Button).matchingIdentifier("Add").elementBoundByIndex(1).tap()
        
        let textField3 = element.childrenMatchingType(.TextField).elementBoundByIndex(0)
        textField3.tap()
        textField3.tap()
        app.textFields.containingType(.Button, identifier:"Clear text").element
        element.childrenMatchingType(.Button).matchingIdentifier("Add").elementBoundByIndex(0).tap()
        textField.tap()
        textField.tap()
        app.textFields.containingType(.Button, identifier:"Clear text").element
        addButton.tap()
        clearAllTagButton.tap()
        app.navigationBars["Babylonian.CourseSettingView"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["Babylonian.CourseView"].buttons["Edit"].tap()
        
        let textField2 = element2.childrenMatchingType(.TextField).elementBoundByIndex(1)
        textField2.tap()
        textField2.tap()
        app.textFields.containingType(.Button, identifier:"Clear text").element
        
        let textField3 = element2.childrenMatchingType(.TextField).elementBoundByIndex(2)
        textField3.tap()
        textField3.tap()
        app.textFields.containingType(.Button, identifier:"Clear text").element
        app.navigationBars["Babylonian.CourseSettingView"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        
        let toolbarsQuery = app.toolbars
        toolbarsQuery.buttons["Press and Hold to Record"].pressForDuration(3.4);
        toolbarsQuery.buttons["+image"].tap()
        app.collectionViews["PhotosGridView"].cells["Photo, Portrait, August 08, 2012, 4:29 PM"].tap()
        app.images["Photo, Portrait, August 08, 2012, 4:29 PM"].tap()
        
        let cell = tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(5)
        cell.childrenMatchingType(.TextView).element.tap()
        cell.childrenMatchingType(.TextView).element
        app.typeText("lkjfda\r")
        babylonianCourseviewNavigationBar.childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        tabBarsQuery.buttons["More..."].tap()
        
        //////////////
    }
    
}
