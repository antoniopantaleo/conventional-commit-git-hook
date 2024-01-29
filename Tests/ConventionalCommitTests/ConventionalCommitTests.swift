//
//  ConventionalCommitTests.swift
//  
//
//  Created by Antonio Pantaleo on 25/01/24.
//

import XCTest
import ConventionalCommit

final class ConventionalCommitTests: XCTestCase {
    
    func test_noMessagesAreInvalid() {
        // When
        let isValid = ConventionalCommit.isValid(messages: [])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_emptyStringFirstMessageIsInvalid() {
        // When
        let isValid = ConventionalCommit.isValid(messages: [""])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_notFormattedCommitMessageIsInvalid() {
        // When
        let isValid = ConventionalCommit.isValid(messages: ["Hello world"])
        // Then
        XCTAssertFalse(isValid)
    }
    
}
