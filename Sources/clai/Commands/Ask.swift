import ArgumentParser
import Foundation

struct Ask: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "ask",
        abstract: "Ask to Apple Intelligence",
        version: "1.0.0"
    )

    @Argument(help: "Prompt to Apple Intelligence")
    var prompt: String

    // MARK: - Init
    func run() async throws {
        let ai = GeneratedContent()

        print("...")

        let response: String = try await ai.answer(prompt)

        cleanScreen()
        print(response)
    }
}
