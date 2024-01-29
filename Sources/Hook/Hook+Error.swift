//
//  Hook+Error.swift
//  
//
//  Created by Antonio Pantaleo on 27/01/24.
//


extension Hook {
    enum Error {
        case invalidCommit
        case noCommitMessage
        
        var message: String {
            switch self {
            case .invalidCommit:
                """
        Invalid commit message format. Please follow conventional commit standards.
        Visit https://www.conventionalcommits.org for reference.
        """
            case .noCommitMessage:
                "Unable to retrieve a commit message"
            }
        }
    }
    static func fail(_ error: Hook.Error) {
        print(error.message)
        exit(1)
    }
}
