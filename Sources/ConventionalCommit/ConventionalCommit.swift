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
        guard let conventionalRegex = try? Regex("^(\(types)):") else { return false }
        return header.starts(with: conventionalRegex)
    }
}
