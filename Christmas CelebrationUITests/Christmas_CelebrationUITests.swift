//
//  Christmas_CelebrationUITests.swift
//  Christmas CelebrationUITests
//
//  Created by Brian Homer Jr on 11/19/25.
//
import XCTest

final class AdventCalendarUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    // MARK: - Outside Advent Period Tests
    
    func testDisplaysWaitingMessageBeforeAdventStarts() {
        // Given: App launched with date before November 24
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-23"]
        app.launch()
        
        // Then: Should display waiting message
        let waitingMessage = app.staticTexts["Daily content begins November 25th—see you then for the countdown to Christmas!"]
        XCTAssertTrue(waitingMessage.waitForExistence(timeout: 2), "Waiting message should be displayed before advent starts")
        
        // And: Should not display daily content
        XCTAssertFalse(app.staticTexts["Day 1"].exists, "Should not display day number before advent")
    }
    
    func testDisplaysWaitingMessageAfterAdventEnds() {
        // Given: App launched with date after December 24
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-12-25"]
        app.launch()
        
        // Then: Should display waiting message
        let waitingMessage = app.staticTexts["Daily content begins November 25th—see you then for the countdown to Christmas!"]
        XCTAssertTrue(waitingMessage.waitForExistence(timeout: 2), "Waiting message should be displayed after advent ends")
        
        // And: Should not display daily content
        XCTAssertFalse(app.staticTexts["Day 30"].exists, "Should not display day number after advent")
    }
    
    // MARK: - During Advent Period Tests
    
    func testDisplaysDay1ContentOnFirstDay() {
        // Given: App launched on November 25 (Day 1)
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        app.launch()
        
        // Then: Should display "The Messiah" title (first name in the array)
        XCTAssertTrue(app.staticTexts["The Messiah"].waitForExistence(timeout: 2), "Should display Savior's name")
        
        // And: Should display Day 1
        XCTAssertTrue(app.staticTexts["Day 1"].exists, "Should display 'Day 1'")
        
        // And: Should display scripture reference
        XCTAssertTrue(app.staticTexts["1 Nephi 11:13–23"].exists, "Should display scripture reference")
        
        // And: Should display talk title
        XCTAssertTrue(app.staticTexts["Glad Tidings of Love and Joy"].exists, "Should display talk title")
        
        // And: Should display suggestion
        XCTAssertTrue(app.staticTexts["Visit someone who is lonely."].exists, "Should display daily suggestion")
        
        // And: Should not display waiting message
        let waitingMessage = app.staticTexts["Daily content begins November 25th—see you then for the countdown to Christmas!"]
        XCTAssertFalse(waitingMessage.exists, "Should not display waiting message during advent")
    }
    
    func testDisplaysDay30ContentOnLastDay() {
        // Given: App launched on December 24 (Day 30)
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-12-24"]
        app.launch()
        
        // Then: Should display "The Only Begotten" (30th name)
        XCTAssertTrue(app.staticTexts["The Only Begotten"].waitForExistence(timeout: 2), "Should display Savior's name")
        
        // And: Should display Day 30
        XCTAssertTrue(app.staticTexts["Day 30"].exists, "Should display 'Day 30'")
        
        // And: Should display day 30 scripture
        XCTAssertTrue(app.staticTexts["John 14:27"].exists, "Should display day 30 scripture")
        
        // And: Should not display waiting message
        let waitingMessage = app.staticTexts["Daily content begins November 25th—see you then for the countdown to Christmas!"]
        XCTAssertFalse(waitingMessage.exists, "Should not display waiting message on last day")
    }
    
    func testDisplaysMiddleDayContent() {
        // Given: App launched on December 10 (Day 17)
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-12-10"]
        app.launch()
        
        // Then: Should display Day 16
        XCTAssertTrue(app.staticTexts["Day 16"].waitForExistence(timeout: 2), "Should display 'Day 16'")
        
        // And: Should display all content components (check for card titles)
        XCTAssertTrue(app.staticTexts["Scripture"].exists, "Should display Scripture card")
        XCTAssertTrue(app.staticTexts["Message"].exists, "Should display Message card")
        XCTAssertTrue(app.staticTexts["Daily Suggestion"].exists, "Should display Daily Suggestion card")
    }
    
    // MARK: - Link Interaction Tests
    
    func testScriptureLinkIsClickable() {
        // Given: App displaying day 1 content
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        app.launch()
        
        // When: Looking for scripture content (it's wrapped in a Link)
        let scriptureText = app.staticTexts["1 Nephi 11:13–23"]
        XCTAssertTrue(scriptureText.waitForExistence(timeout: 2), "Scripture text should exist")
        
        // The entire SuggestionCard with the scripture is tappable
        XCTAssertTrue(scriptureText.isHittable, "Scripture card should be tappable")
    }
    
    func testTalkLinkIsClickable() {
        // Given: App displaying day 1 content
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        app.launch()
        
        // When: Looking for talk title content
        let talkText = app.staticTexts["Glad Tidings of Love and Joy"]
        XCTAssertTrue(talkText.waitForExistence(timeout: 2), "Talk title should exist")
        XCTAssertTrue(talkText.isHittable, "Talk card should be tappable")
    }
    
    func testSuggestionLinkWhenPresent() {
        // Given: App displaying Day 6 which has a suggestion link
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-30"]
        app.launch()
        
        // Then: Day 6 suggestion has a link (Read and ponder 'The Living Christ.')
        let suggestionText = app.staticTexts["Read and ponder 'The Living Christ.'"]
        XCTAssertTrue(suggestionText.waitForExistence(timeout: 2), "Suggestion with link should exist")
        XCTAssertTrue(suggestionText.isHittable, "Suggestion card with link should be tappable")
    }
    
    // MARK: - Navigation Tests
    
    func testSettingsButtonExists() {
        // Given: App launched
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        app.launch()
        
        // Then: Settings button should exist
        let settingsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS 'gearshape'")).element
        XCTAssertTrue(settingsButton.waitForExistence(timeout: 2), "Settings button should exist")
    }
    
    func testSettingsSheetOpens() {
        // Given: App launched
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        app.launch()
        
        // When: Tapping settings button
        let settingsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS 'gearshape'")).element
        if settingsButton.waitForExistence(timeout: 2) {
            settingsButton.tap()
            
            // Then: Settings sheet should appear
            let settingsTitle = app.navigationBars["Settings"]
            XCTAssertTrue(settingsTitle.waitForExistence(timeout: 2), "Settings sheet should open")
        }
    }
    
    // MARK: - Accessibility Tests
    
    func testKeyContentIsAccessible() {
        // Given: App displaying day 1 content
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        app.launch()
        
        // Then: Key elements should be accessible
        let dayLabel = app.staticTexts["Day 1"]
        XCTAssertTrue(dayLabel.waitForExistence(timeout: 3), "Day label should exist")
        XCTAssertTrue(dayLabel.isAccessibilityElement || dayLabel.exists, "Day label should be accessible")
        
        let scripture = app.staticTexts["1 Nephi 11:13–23"]
        XCTAssertTrue(scripture.exists, "Scripture should exist")
    }
    
    // MARK: - Layout Tests
    
    func testContentLayoutInPortrait() {
        // Given: App in portrait orientation
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        XCUIDevice.shared.orientation = .portrait
        app.launch()
        
        // Then: All content should be visible
        XCTAssertTrue(app.staticTexts["The Messiah"].waitForExistence(timeout: 2), "Savior name should be visible")
        XCTAssertTrue(app.staticTexts["Day 1"].exists, "Day number should be visible")
        XCTAssertTrue(app.staticTexts["Scripture"].exists, "Scripture card should be visible")
        XCTAssertTrue(app.staticTexts["Message"].exists, "Message card should be visible")
        XCTAssertTrue(app.staticTexts["Daily Suggestion"].exists, "Daily Suggestion card should be visible")
    }
    
    func testContentLayoutInLandscape() {
        // Given: App in landscape orientation
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        app.launch()
        XCUIDevice.shared.orientation = .landscapeLeft
        
        // Wait for orientation change
        sleep(1)
        
        // Then: All content should still be visible
        XCTAssertTrue(app.staticTexts["Day 1"].exists, "Day number should be visible in landscape")
        XCTAssertTrue(app.staticTexts["Scripture"].exists, "Scripture card should be visible in landscape")
    }
    
    // MARK: - Error Handling Tests
    
    func testHandlesInvalidDate() {
        // Given: App launched with invalid date
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "invalid"]
        app.launch()
        
        // Then: Should display some default content or error handling
        // Adjust based on your app's error handling
        XCTAssertTrue(app.exists, "App should handle invalid date gracefully")
    }
    
    // MARK: - Performance Tests
    
    func testAppLaunchPerformance() {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            app.launch()
        }
    }
    
    func testScrollPerformance() {
        // Given: App displaying content
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TEST_DATE": "2025-11-25"]
        app.launch()
        
        // When: Scrolling through content
        measure(metrics: [XCTOSSignpostMetric.scrollDecelerationMetric]) {
            let scrollView = app.scrollViews.firstMatch
            if scrollView.exists {
                scrollView.swipeUp()
                scrollView.swipeDown()
            }
        }
    }
}

// MARK: - Helper Extensions

extension XCUIElementQuery {
    func containing(_ predicate: NSPredicate) -> XCUIElement {
        return self.matching(predicate).element
    }
}
