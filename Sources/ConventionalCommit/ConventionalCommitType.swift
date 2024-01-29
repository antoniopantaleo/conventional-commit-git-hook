//
//  ConventionalCommitType.swift
//
//
//  Created by Antonio Pantaleo on 25/01/24.
//

import Foundation

enum ConventionalCommitType: String, CaseIterable {
    case feat
    case fix
    case build
    case chore
    case ci
    case docs
    case style
    case refactor
    case perf
    case test
}
