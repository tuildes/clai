import ArgumentParser
import Foundation

struct Clai {

    @available(macOS 26.0, *)
    @main
    struct clai: AsyncParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Command Line Apple Intelligence",
            version: "1.0.0",
            subcommands: [Ask.self, ObsidianAnalyze.self, Fix.self],
            defaultSubcommand: Ask.self
        )
    }

    static func main() {
        clai.main()
    }
}
