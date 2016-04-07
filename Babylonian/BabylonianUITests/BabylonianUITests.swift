//
//  BabylonianUITests.swift
//  BabylonianUITests
//
//  Created by Eric Smith on 3/6/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//


import XCTest

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
        app.buttons["+Add New Course"].tap()
        
        let toolbarsQuery = app.toolbars
        let pressAndHoldToRecordButton = toolbarsQuery.buttons["Press and Hold to Record"]
        pressAndHoldToRecordButton.tap()
        
        let imageButton = toolbarsQuery.buttons["+image"]
        imageButton.tap()
        
        let photoLandscapeAugust082012152PmCell = app.collectionViews["PhotosGridView"].cells["Photo, Landscape, August 08, 2012, 1:52 PM"]
        photoLandscapeAugust082012152PmCell.tap()
        
        let window = app.childrenMatchingType(.Window).elementBoundByIndex(0)
        let element = window.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element
        element.tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells.childrenMatchingType(.TextView).element.tap()
        
        let cell = tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(0)
        cell.childrenMatchingType(.TextView).element.tap()
        cell.childrenMatchingType(.TextView).element
        app.typeText("\r")
        pressAndHoldToRecordButton.tap()
        
        let cell2 = tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(2)
        let textView = cell2.childrenMatchingType(.TextView).element
        textView.tap()
        textView.tap()
        cell2.childrenMatchingType(.TextView).element
        app.typeText("\r")
        
        let babylonianCourseviewNavigationBar = app.navigationBars["Babylonian.CourseView"]
        let editButton = babylonianCourseviewNavigationBar.buttons["Edit"]
        editButton.tap()
        window.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Table).element.swipeUp()
        
        let doneButton = babylonianCourseviewNavigationBar.buttons["Done"]
        doneButton.tap()
        imageButton.tap()
        photoLandscapeAugust082012152PmCell.tap()
        element.tap()
        editButton.pressForDuration(2.4);
        tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(1).buttons["Delete Label"].tap()
        
        let tablesQuery2 = tablesQuery
        tablesQuery2.buttons["Delete"].tap()
        doneButton.tap()
        pressAndHoldToRecordButton.tap()
        babylonianCourseviewNavigationBar.childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        tabBarsQuery.buttons["Discussions"].tap()
        tabBarsQuery.buttons["More..."].tap()
        
        let showLocationSwitch = tablesQuery2.switches["Show Location"]
        showLocationSwitch.tap()
        showLocationSwitch.tap()
        
        let connectedToFbSwitch = tablesQuery2.switches["Connected to FB"]
        connectedToFbSwitch.tap()
        connectedToFbSwitch.tap()
        
        let connectedToTwitterSwitch = tablesQuery2.switches["Connected to Twitter"]
        connectedToTwitterSwitch.tap()
        connectedToTwitterSwitch.tap()
        app.buttons["Logout"].tap()
        app.buttons["Login"].tap()
        tablesQuery2.textFields["Email"].tap()
        
        let tablesQuery3 = app.otherElements.containingType(.NavigationBar, identifier:"Login").tables
        tablesQuery3.childrenMatchingType(.Cell).elementBoundByIndex(0).childrenMatchingType(.TextField).element
        tablesQuery2.secureTextFields["Password"].tap()
        tablesQuery3.childrenMatchingType(.Cell).elementBoundByIndex(1).childrenMatchingType(.SecureTextField).element
        tablesQuery2.staticTexts["ENTER"].tap()
      
        //////////////
    }
    
}
