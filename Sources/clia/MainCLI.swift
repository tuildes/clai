import ArgumentParser
import Foundation

struct MainCLI {

    @available(macOS 26.0, *)
    @main
    struct cli: AsyncParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Apple Inteligence CLI",
            version: "0.0.1"
        )

        @Argument(help: "Prompt to Apple Inteligence")
        var prompt: String

        // @Flag(help: "Whether to say the name capitalized.") var capitalized: Bool = false

        // MARK: - Init
        func run() async throws {
            let ai = GeneratedContent()

            print("...")

            let response: String = try await ai.answer(prompt)
            print("\u{001B}[2J")  // Clean Screen
            print(response)
        }
    }

    static func main() {
        cli.main()
    }
}
