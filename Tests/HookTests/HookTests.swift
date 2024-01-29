//
//  HookTests.swift
//  
//
//  Created by Antonio Pantaleo on 27/01/24.
//

import XCTest

final class HookTests: XCTestCase {
    
    private let fileManager = FileManager.default
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        try fileManager.createDirectory(
            at: temporaryCommitMessageFilePath,
            withIntermediateDirectories: false
        )
    }
    
    override func tearDownWithError() throws {
        try fileManager.removeItem(at: temporaryCommitMessageFilePath)
        try super.tearDownWithError()
    }
    
    func test_hookSuccedsWithValidCommitMessageFile() throws {
        let filePath = createFakeCommitFile(withMessage: "feat(core)!: hello world")
        XCTAssertNoThrow(try simulateHookExecution(filePath: filePath))
    }
    
    func test_hookDeliversErrorOnEmptyCommitMessageFile() throws {
        let filePath = createFakeCommitFile(withMessage: "")
        XCTAssertThrowsError(try simulateHookExecution(filePath: filePath))
    }
    
    func test_hookDeliversErrorWithMissingCommitMessageFile() throws {
        XCTAssertThrowsError(try simulateHookExecution(filePath: nil))
    }
    
    // MARK: Helpers
    
    private var temporaryCommitMessageFilePath: URL {
        fileManager.temporaryDirectory.appending(path: "HookTests")
    }

    private func createFakeCommitFile(withMessage message: String) -> String {
        let filePath = temporaryCommitMessageFilePath.appending(path: "COMMIT_MSG").path()
        fileManager.createFile(atPath: filePath, contents: message.data(using: .utf8))
        return filePath
    }
    
    private func simulateHookExecution(filePath: String?) throws {
        let process = Process()
        let executablePath = fileManager.currentDirectoryPath + "/commit-msg"
        process.executableURL = URL(filePath: executablePath)
        if let filePath {
            process.arguments = [filePath]
        }
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        try process.run()
        process.waitUntilExit()
        
        guard Int(process.terminationStatus) == 0 else {
            let error = NSError(domain: "Hook error", code: Int(process.terminationStatus))
            throw error
        }
    }
    
}
