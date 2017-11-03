//
//  Nike_CollectionUITests.swift
//  Nike CollectionUITests
//
//  Created by Shao Kahn on 10/4/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import XCTest

class Nike_CollectionUITests: XCTestCase {
    var app = XCUIApplication()
    override func setUp() {
        super.setUp()
        app.launch()
        
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
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 2).children(matching: .other).element.tap()
        
        let tabBarsQuery = app.tabBars
        let item2Button = tabBarsQuery.buttons["Item 2"]
        item2Button.tap()
        item2Button.tap()
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
}
