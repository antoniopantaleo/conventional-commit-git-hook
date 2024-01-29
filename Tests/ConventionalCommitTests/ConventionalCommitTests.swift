//
//  ConventionalCommitTests.swift
//  
//
//  Created by Antonio Pantaleo on 25/01/24.
//

import XCTest
@testable import ConventionalCommit

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
        let header = "Hello world"
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_formattedOnlyHeaderCommitMessageIsValid() {
        // When
        let header = "feat: hello world"
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertTrue(isValid)
    }
    
    func test_headerMessageThatStartsWithAValidTypeIsValid() {
        // When
        let types = ConventionalCommitType.allCases.map(\.rawValue)
        types.forEach { type in
            let header = "\(type): hello world"
            let isValid = ConventionalCommit.isValid(messages: [header])
            // Then
            XCTAssertTrue(isValid)
        }
    }
    
    func test_headerMessageWithNoColonAfterTypeIsNotValid() {
        // When
        let header = "feat hello world"
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithNoSpaceAfterColonIsNotValid() {
        // When
        let header = "feat:hello world"
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithNoMessageAfterTypeIsNotValid() {
        // When
        let header = "feat: "
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithBreakingChangeExclamationIsValid() {
        // When
        let header = "feat!: hello world"
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertTrue(isValid)
    }
    
    func test_headerMessageWithNoScopeAndEmptyBracketsIsNotValid() {
        // Given
        let header = "chore(): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithScopeWithinBracketsIsValid() {
        // Given
        let header = "chore(scope): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertTrue(isValid)
    }
    
    func test_headerMessageWithTwoWordsScopeWithinBracketsIsValid() {
        // Given
        let header = "chore(hello-world): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertTrue(isValid)
    }
    
    func test_headerMessageWithSemiCapitalizedScopeWithinBracketsIsNotValid() {
        // Given
        let header = "chore(Hello-WOrld): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithFullCapitalizedScopeWithinBracketsIsNotValid() {
        // Given
        let header = "chore(HELLO): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithNoLetterScopeWithinBracketsIsNotValid() {
        // Given
        let header = "chore(-): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithLeadingTrailingDashScopeWithinBracketsIsNotValid() {
        // Given
        let header = "chore(-helloworld-): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithLeadingTrailingCenterDashScopeWithinBracketsIsNotValid() {
        // Given
        let header = "chore(-hello-world-): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithTrailingDashScopeWithinBracketsIsNotValid() {
        // Given
        let header = "chore(hello-world-): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
    
    func test_headerMessageWithLeadingDashScopeWithinBracketsIsNotValid() {
        // Given
        let header = "chore(-hello-world): hello world"
        // When
        let isValid = ConventionalCommit.isValid(messages: [header])
        // Then
        XCTAssertFalse(isValid)
    }
}
