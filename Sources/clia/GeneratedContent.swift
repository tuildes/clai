import FoundationModels

struct GeneratedContent {
    let model: SystemLanguageModel
    let session: LanguageModelSession

    init() {
        self.model = .init(guardrails: .permissiveContentTransformations)
        self.session = LanguageModelSession(
            model: self.model
        )

        guard model.isAvailable else {
            fatalError(
                "ERROR: Model are unvailable. Maybe you need install the Apple Inteligence..."
            )
        }
    }

    public func answer(_ to: String) async throws -> String {
        let response = try await session.respond(
            to: Prompt(to)
        )

        return response.content
    }
}
