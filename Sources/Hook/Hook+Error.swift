//
//  Hook+Error.swift
//  
//
//  Created by Antonio Pantaleo on 27/01/24.
//

import Darwin

extension Hook {
    enum Error {
        case invalidCommit
        case noCommitMessage
        
        var message: String {
            switch self {
            case .invalidCommit:
                return """
        Invalid commit message format. Please follow conventional commit standards.
        Visit https://www.conventionalcommits.org for reference.
        """
            case .noCommitMessage:
                return "Unable to retrieve a commit message"
            }
        }
    }
    static func fail(_ error: Hook.Error) {
        print(error.message)
        exit(1)
    }
}
