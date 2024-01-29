import ConventionalCommit

@main
struct Hook {
    static func main() throws {
        guard CommandLine.arguments.count > 1 else { return fail(.noCommitMessage) }
        let commitMessagePath = CommandLine.arguments[1]
        guard
            let content = try? String(contentsOfFile: commitMessagePath, encoding: .utf8),
            let headerMessage = content.components(separatedBy: .newlines).first
        else { return fail(.noCommitMessage) }
        guard ConventionalCommit.isValid(header: headerMessage) else { return fail(.invalidCommit) }
        exit(0)
    }
}
