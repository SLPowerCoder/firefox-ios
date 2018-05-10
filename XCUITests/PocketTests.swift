/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class PocketTest: BaseTestCase {

    func testPocketEnabledByDefault() {
        navigator.goto(NewTabScreen)
        waitforExistence(app.staticTexts["Recommended by Pocket"])

        // There should be two stories
        let numPocketStories = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.cell, identifier:"TopSitesCell")/*[[".otherElements[\"Top sites\"].collectionViews.containing(.cell, identifier:\"TopSitesCell\")",".collectionViews.containing(.cell, identifier:\"TopSitesCell\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).count-1
        if iPad() {
            XCTAssertEqual(numPocketStories, 3)
        } else {
            XCTAssertEqual(numPocketStories, 2)
        }
        // Tap on the first Pocket element
        app/*@START_MENU_TOKEN@*/.collectionViews.containing(.cell, identifier:"TopSitesCell")/*[[".otherElements[\"Top sites\"].collectionViews.containing(.cell, identifier:\"TopSitesCell\")",".collectionViews.containing(.cell, identifier:\"TopSitesCell\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 1).tap()
        waitUntilPageLoad()
        waitForValueContains(app.textFields["url"], value: "www")
    }

    func testDisablePocket() {
        navigator.performAction(Action.TogglePocketInNewTab)
        navigator.goto(NewTabScreen)
        waitforNoExistence(app.staticTexts["Recommended by Pocket"])
        // Enable it again
        navigator.performAction(Action.TogglePocketInNewTab)
        navigator.goto(NewTabScreen)
        waitforExistence(app.staticTexts["Recommended by Pocket"])
    }

    func testTapOnMore() {
        // Tap on More should show Pocket website
        navigator.goto(NewTabScreen)
        app.buttons["More"].tap()
        waitUntilPageLoad()
        waitForValueContains(app.textFields["url"], value: "getpocket")
    }
}
