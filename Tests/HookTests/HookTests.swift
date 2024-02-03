//
//  HookTests.swift
//  
//
//  Created by Antonio Pantaleo on 27/01/24.
//

import Logging
import XCTest

final class HookTests: XCTestCase {
    
    private let logger = Logger(label: "HookTests")
    private let fileManager = FileManager.default
    
    override class func setUp() {
        super.setUp()
        LoggingSystem.bootstrap(StreamLogHandler.standardError)
    }
    
    override func setUp() {
        super.setUp()
        try? fileManager.createDirectory(
            at: temporaryCommitMessageFilePath,
            withIntermediateDirectories: false
        )
    }
    
    override func tearDown() {
        try? fileManager.removeItem(at: temporaryCommitMessageFilePath)
        super.tearDown()
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
    
    private func logBinaryArchitecture(at url: URL?) {
        guard let url = url else {
            return logger.error("No URL exists")
        }
        let process = Process()
        process.executableURL = URL(filePath: "/usr/bin/lipo")
        logger.info("lipo executable path is \(process.executableURL?.path() ?? "none")")
        process.arguments = ["-info", url.path()]
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        do {
            try process.run()
        } catch {
            logger.error("log binary architecture failed with error: \(error)")
        }
        process.waitUntilExit()
        do {
            guard let data = try pipe.fileHandleForReading.readToEnd(), let stringData = String(data: data, encoding: .utf8) else {
                return logger.error("Not able to collect data")
            }
            logger.info("Architecture \(stringData)")
        } catch {
            logger.error("reading logged architecture failed with error: \(error)")
        }
    }
    
    private func simulateHookExecution(filePath: String?) throws {
        let process = Process()
        let executablePath = fileManager.currentDirectoryPath + "/commit-msg"
        process.executableURL = URL(filePath: executablePath)
        logBinaryArchitecture(at: process.executableURL)
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
