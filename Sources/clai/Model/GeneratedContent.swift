import FoundationModels

struct GeneratedContent {
    let model: SystemLanguageModel
    let session: LanguageModelSession

    init(instructions: String? = nil) {
        self.model = .init(guardrails: .permissiveContentTransformations)
        self.session = LanguageModelSession(
            model: self.model,
            instructions: instructions
        )

        guard model.isAvailable else {
            fatalError(
                "ERROR: Model are unavailable. Maybe, you need install the Apple Intelligence ir your macOS..."
            )
        }
    }

    public func answer(_ prompt: String) async throws -> String {
        let response = try await session.respond(
            to: Prompt(prompt)
        )

        return response.content
    }
}
