import ArgumentParser
import Foundation

struct Fix: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Fix text in file"
    )

    @Argument(help: "Text file path", transform: URL.init(fileURLWithPath:))
    var file: URL

    mutating func validate() throws {
        guard FileManager.default.fileExists(atPath: file.path) else {
            throw ValidationError("File does not exist at \(file.path)")
        }
    }

    private func getContentOfMarkdown() throws -> String {
        let content = try String(contentsOf: file, encoding: .utf8)
        return content
    }

    // MARK: - Init
    func run() async throws {
        fatalError("Not implemented")
    }
}
