import ArgumentParser
import Foundation

struct Ask: AsyncParsableCommand {
    @Argument(help: "Prompt to Apple Inteligence")
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
