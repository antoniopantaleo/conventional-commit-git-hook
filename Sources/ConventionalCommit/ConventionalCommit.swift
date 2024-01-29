//
//  ConventionalCommit.swift
//  
//
//  Created by Antonio Pantaleo on 25/01/24.
//

import Foundation

public enum ConventionalCommit {
    
    public static func isValid(messages: [String]) -> Bool {
        let types = ConventionalCommitType.allCases.map(\.rawValue).joined(separator:"|")
        guard
            let conventionalRegex = try? Regex("^(\(types))"),
            let firstMessage = messages.first
        else { return false }
        return firstMessage.starts(with: conventionalRegex)
    }
}
