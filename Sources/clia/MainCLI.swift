import ArgumentParser
import Foundation

struct MainCLI {

    @available(macOS 26.0, *)
    @main
    struct cli: AsyncParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Apple Inteligence CLI",
            version: "0.0.5",
            subcommands: [Ask.self, ObsidianAnalyze.self],
            defaultSubcommand: Ask.self
        )
    }

    static func main() {
        cli.main()
    }
}
