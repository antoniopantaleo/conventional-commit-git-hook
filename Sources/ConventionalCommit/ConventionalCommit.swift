//
//  ConventionalCommit.swift
//  
//
//  Created by Antonio Pantaleo on 25/01/24.
//

import Foundation

public enum ConventionalCommit {
    
    public static func isValid(messages: [String]) -> Bool {
        guard let header = messages.first else { return false }
        let types = ConventionalCommitType.allCases.map(\.rawValue).joined(separator:"|")
        let scope = #"(\([a-z]+(?:-[a-z]+)*[a-z]\))?"#
        let breakingChange = "(!)?"
        let message = ".+"
        guard let conventionalRegex = try? Regex("^(\(types))\(scope)\(breakingChange): \(message)$") else { return false }
        return header.starts(with: conventionalRegex)
    }
}
