//
//  Christmas_CelebrationTests.swift
//  Christmas CelebrationTests
//
//  Created by Brian Homer Jr on 11/19/25.
//
import XCTest
@testable import Christmas_Celebration

final class AdventCalendarTests: XCTestCase {
    
    let calendar = Calendar.current
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Date Range Tests
    
    func testDateBeforeAdventPeriod() {
        // Given: A date before November 25, 2025 (Day 1 is Nov 25 in your data)
        let testDate = calendar.date(from: DateComponents(year: 2025, month: 11, day: 24))!
        
        // When: Getting suggestion for that date
        let result = DailySuggestion.allSuggestions.first { suggestion in
            calendar.isDate(suggestion.date, inSameDayAs: testDate)
        }
        
        // Then: Should not find a matching suggestion
        XCTAssertNil(result, "Should not return daily suggestion before advent period")
    }
    
    func testDateAfterAdventPeriod() {
        // Given: A date after December 24, 2025
        let testDate = calendar.date(from: DateComponents(year: 2025, month: 12, day: 25))!
        
        // When: Getting suggestion for that date
        let result = DailySuggestion.allSuggestions.first { suggestion in
            calendar.isDate(suggestion.date, inSameDayAs: testDate)
        }
        
        // Then: Should not find a matching suggestion
        XCTAssertNil(result, "Should not return daily suggestion after advent period")
    }
    
    func testFirstDayOfAdventPeriod() {
        // Given: November 25, 2025 (first day in your data)
        let testDate = calendar.date(from: DateComponents(year: 2025, month: 11, day: 25))!
        
        // When: Getting content
        let result = DailySuggestion.allSuggestions.first { suggestion in
            calendar.isDate(suggestion.date, inSameDayAs: testDate)
        }
        
        // Then: Should return day 1 content
        XCTAssertNotNil(result, "Should return daily suggestion on first day")
        XCTAssertEqual(result?.day, 1)
        XCTAssertEqual(result?.scripture, "1 Nephi 11:13–23")
    }
    
    func testLastDayOfAdventPeriod() {
        // Given: December 24, 2025 (last day - day 30)
        let testDate = calendar.date(from: DateComponents(year: 2025, month: 12, day: 24))!
        
        // When: Getting content
        let result = DailySuggestion.allSuggestions.first { suggestion in
            calendar.isDate(suggestion.date, inSameDayAs: testDate)
        }
        
        // Then: Should return day 30 content
        XCTAssertNotNil(result, "Should return daily suggestion on last day")
        XCTAssertEqual(result?.day, 30)
        XCTAssertEqual(result?.scripture, "John 14:27")
    }
    
    func testMiddleDayOfAdventPeriod() {
        // Given: December 10, 2025 (day 17)
        let testDate = calendar.date(from: DateComponents(year: 2025, month: 12, day: 10))!
        
        // When: Getting content
        let result = DailySuggestion.allSuggestions.first { suggestion in
            calendar.isDate(suggestion.date, inSameDayAs: testDate)
        }
        
        // Then: Should return appropriate day content
        XCTAssertNotNil(result, "Should return daily suggestion during advent period")
        XCTAssertEqual(result?.day, 16)
    }
    
    // MARK: - Daily Suggestion Content Tests
    
    func testDailySuggestionStructure() {
        // Given: A date within the advent period
        let testDate = calendar.date(from: DateComponents(year: 2025, month: 11, day: 25))!
        
        // When: Getting the daily suggestion
        let result = DailySuggestion.allSuggestions.first { suggestion in
            calendar.isDate(suggestion.date, inSameDayAs: testDate)
        }
        
        // Then: Should have all required fields
        XCTAssertNotNil(result?.scripture)
        XCTAssertNotNil(result?.scriptureLink)
        XCTAssertNotNil(result?.talkTitle)
        XCTAssertNotNil(result?.talkLink)
        XCTAssertNotNil(result?.suggestion)
        XCTAssertNotNil(result?.date)
    }
    
    func testDayNumberProgression() {
        // Given: All suggestions in the array
        let allSuggestions = DailySuggestion.allSuggestions
        
        // Then: Should have exactly 30 suggestions
        XCTAssertEqual(allSuggestions.count, 30, "Should have 30 days of suggestions")
        
        // And: Day numbers should progress from 1 to 30
        for (index, suggestion) in allSuggestions.enumerated() {
            XCTAssertEqual(suggestion.day, index + 1, "Day \(index + 1) should match array position")
        }
    }
    
    func testScriptureLinksAreValid() {
        // Given: All suggestions
        let allSuggestions = DailySuggestion.allSuggestions
        
        // Then: All scripture links should be valid URLs
        for suggestion in allSuggestions {
            XCTAssertNotNil(suggestion.scriptureLink, "Day \(suggestion.day) should have scripture link")
            XCTAssertTrue(suggestion.scriptureLink?.absoluteString.hasPrefix("https://") ?? false, "Day \(suggestion.day) scripture link should use https")
        }
    }
    
    func testTalkLinksAreValid() {
        // Given: All suggestions
        let allSuggestions = DailySuggestion.allSuggestions
        
        // Then: All talk links should be valid URLs
        for suggestion in allSuggestions {
            XCTAssertNotNil(suggestion.talkLink, "Day \(suggestion.day) should have talk link")
            XCTAssertTrue(suggestion.talkLink?.absoluteString.hasPrefix("https://") ?? false, "Day \(suggestion.day) talk link should use https")
        }
    }
    
    // MARK: - Edge Case Tests
    
    func testTodayMethodReturnsCorrectSuggestion() {
        // Given: Today's date
        let today = Date()
        
        // When: Getting today's suggestion
        let todaySuggestion = DailySuggestion.today()
        
        // Then: Should match the manual lookup
        let manualLookup = DailySuggestion.allSuggestions.first { suggestion in
            calendar.isDate(suggestion.date, inSameDayAs: today)
        }
        
        XCTAssertEqual(todaySuggestion?.day, manualLookup?.day, "today() method should return same result as manual lookup")
    }
    
    func testDatesMarchCorrectly() {
        // Given: Check that dates progress correctly
        let allSuggestions = DailySuggestion.allSuggestions
        
        // Day 1 should be Nov 24
        let day1 = allSuggestions[0]
        let day1Components = calendar.dateComponents([.month, .day], from: day1.date)
        XCTAssertEqual(day1Components.month, 11)
        XCTAssertEqual(day1Components.day, 25)
        
        // Day 30 should be Dec 24
        let day30 = allSuggestions[29]
        let day30Components = calendar.dateComponents([.month, .day], from: day30.date)
        XCTAssertEqual(day30Components.month, 12)
        XCTAssertEqual(day30Components.day, 24)
    }
}

// MARK: - Model Tests

extension AdventCalendarTests {
    
    func testDailySuggestionModelCreation() {
        // Given: Valid parameters
        let date = calendar.date(from: DateComponents(year: 2025, month: 11, day: 24))!
        let scriptureURL = URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/1-ne/11")
        let talkURL = URL(string: "https://www.churchofjesuschrist.org/study/liahona/2025/01/04-glad-tidings")
        
        // When: Creating a DailySuggestion
        let suggestion = DailySuggestion(
            day: 1,
            date: date,
            scripture: "1 Nephi 11:13–23",
            scriptureLink: scriptureURL,
            talkTitle: "Glad Tidings of Love and Joy",
            talkLink: talkURL,
            suggestion: "Visit someone who is lonely.",
            suggestionLink: nil
        )
        
        // Then: All properties should be set correctly
        XCTAssertEqual(suggestion.day, 1)
        XCTAssertEqual(suggestion.date, date)
        XCTAssertEqual(suggestion.scripture, "1 Nephi 11:13–23")
        XCTAssertEqual(suggestion.scriptureLink, scriptureURL)
        XCTAssertEqual(suggestion.talkTitle, "Glad Tidings of Love and Joy")
        XCTAssertEqual(suggestion.talkLink, talkURL)
        XCTAssertEqual(suggestion.suggestion, "Visit someone who is lonely.")
        XCTAssertNil(suggestion.suggestionLink)
    }
    
    func testAllSuggestionsHaveUniqueIDs() {
        // Given: All suggestions
        let allSuggestions = DailySuggestion.allSuggestions
        
        // When: Extracting all IDs
        let ids = allSuggestions.map { $0.id }
        let uniqueIds = Set(ids)
        
        // Then: All IDs should be unique
        XCTAssertEqual(ids.count, uniqueIds.count, "All suggestions should have unique IDs")
    }
}
