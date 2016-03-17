//
//  UserModelTests.swift
//  Babylonian
//
//  Created by Ben Freeman on 3/14/16.
//  Copyright © 2016 Eric Smith. All rights reserved.
//

import XCTest
@testable import Babylonian

class UserModelTests: XCTestCase {
    
    var u = User(username: "TestUser1", email: "test@example.com")

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        u = User(username: "TestUser1", email: "test@example.com")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //the user's username should not be blank
    func testUserHasUsername() {
        XCTAssert(u.username != "")
    }
    
    //the user's email should not be blank
    func testUserHasEmail() {
        XCTAssert(u.email != "")
    }
    
    //calling the login method with valid credentials should succeed and return a unique uid
    func testUserCanLogInWithCorrectAuthentication() {

    }
    
    //calling the login method with invalid credentials should fail
    func testUserCannotLogInWithBadAuthentication() {
    
    }
    
    //calling the logout function should deauthenticate the user
    func testUserCanLogOut() {
    
    }
    
    //calling the changeEmail function should update the user's email
    func testUserCanChangeEmail() {
    
    }
    
    func testMiscellany() {
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
