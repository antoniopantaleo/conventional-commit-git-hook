import ConventionalCommit

@main
struct Hook {
    static func main() throws {
        print("Hello, world!", CommandLine.arguments[1...])
    }
}
