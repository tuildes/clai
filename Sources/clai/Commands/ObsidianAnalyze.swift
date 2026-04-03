import ArgumentParser
import Foundation

// NOTE: - This is maded for my personal use, you can change for your best practices
struct ObsidianAnalyze: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "obs",
        abstract: "Obsidian note analyze: Anki and Atomic",
        version: "1.0.0"
    )


    @Argument(help: "Markdown file path", transform: URL.init(fileURLWithPath:))
    var file: URL

    mutating func validate() throws {
        guard FileManager.default.fileExists(atPath: file.path) else {
            throw ValidationError("File does not exist at \(file.path)")
        }
    }

    private func getContentOfMarkdown() throws -> String {
        let content = try String(contentsOf: file, encoding: .utf8)
        if !content.hasPrefix("---") { return content }

        guard let firstRange = content.range(of: "---") else { return content }
        var searchRange = firstRange.upperBound..<content.endIndex
        if let secondRange = content.range(of: "---", options: [], range: searchRange) {
            searchRange = secondRange.upperBound..<content.endIndex

            // Remover secao de updates
            if let thirdRange = content.range(of: "---", options: [], range: searchRange) {
                return String(content[secondRange.upperBound...thirdRange.lowerBound])
            }

            return String(content[secondRange.upperBound...])
        }

        return content
    }

    // MARK: - Init
    func run() async throws {
        let ai = GeneratedContent(
            instructions:
                """
                Act like a Senior Software Engineer and expert in the Zettelkasten method. Analyze the Markdown content below following these criteria:

                Atomicity: Check if the note focuses on only one single concept or principle. Only suggest splitting when the topics are fundamentally different domains (e.g., "Hash Algorithms" and "Brute Force"). Closely related subtopics within the same domain (e.g., SHA-256 and SHA-512) belong together and should NOT be split. A short note covering one main subject with its basic properties (what it does, advantages, how to verify) is atomic — don't split just because there are subtopics.

                Anki Extraction: Identify technical concepts with high long-term retention value. Focus on distinctive, non-obvious knowledge — things a senior engineer would actually forget or confuse. Skip trivial definitions, obvious facts, and basic "what is X" questions unless the concept is genuinely hard to remember. Vary the card style: comparisons, edge cases, gotchas, trade-offs, "when would you choose X over Y", common mistakes. Avoid repetitive "Why is X important" / "What is X" patterns. Just extract the main points from the text.

                Response Rules:
                - Be concise and direct, in plaintext. No explanations, no justifications.
                - If the note IS atomic and there IS Anki content: Confirm atomicity, then list Anki topics.
                - If the note IS atomic and there is NO relevant Anki content: Respond exactly: "The file is atomic. No Anki notes are needed for this topic."
                - If the note is NOT atomic: Start with "The [title] note can be split into [Topic A] and [Topic B]", then list Anki topics.

                Example valid output:
                "The file isn't atomic. Suggested new notes:
                1. VPN
                2. Network tunneling

                Suggested Anki topics:
                1. Difference between encryption at rest vs in transit,
                2. When does a VPN NOT protect you"
                """
        )

        print("...")

        let response: String = try await ai.answer(try getContentOfMarkdown())
        cleanScreen()
        print(response)
    }
}
