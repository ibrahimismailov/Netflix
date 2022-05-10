

//
//  NetflixUITests.swift
//  NetflixUITests
//
//  Created by Abraam on 28.03.2022.
//

import XCTest

class NetflixUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let app2 = app
        let tablesQuery2 = app2.tables
        let tablesQuery = tablesQuery2
        tablesQuery.children(matching: .cell).element(boundBy: 1).tap()


        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Search"].tap()

        let searchSearchField = app.navigationBars["Search"].searchFields["Search"]
        searchSearchField.tap()
        
        tabBar.buttons["Download"].tap()
        
        let starTrekPicardCell = tablesQuery.cells.containing(.staticText, identifier:"Star Trek: Picard").element
        starTrekPicardCell.swipeUp()
        starTrekPicardCell.tap()


    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
