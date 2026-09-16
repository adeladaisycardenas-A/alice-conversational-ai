import Foundation

#if canImport(FoundationModels)
import FoundationModels

/// Alice's free system-managed brain. The model is supplied by Apple
/// Intelligence, so Pocket Alice does not bundle model weights or an API key.
struct AppleFoundationBrain: AliceBrain {
    var displayName: String {
        switch SystemLanguageModel.default.availability {
        case .available:
            "Apple Intelligence · Private on device"
        case .unavailable(.deviceNotEligible):
            "Prototype · Device not eligible"
        case .unavailable(.appleIntelligenceNotEnabled):
            "Prototype · Enable Apple Intelligence"
        case .unavailable(.modelNotReady):
            "Prototype · Apple model downloading"
        case .unavailable:
            "Prototype · Apple model unavailable"
        }
    }

    func respond(
        to message: String,
        identity: AliceIdentity,
        history: [AliceMessage],
        mode: AliceInteractionMode,
        memories: [AliceMemoryRecord],
        lifeMap: [AliceLifeMapEntry]
    ) async -> String {
        let model = SystemLanguageModel.default

        guard case .available = model.availability else {
            let fallbackResponse = await fallback(
                message: message,
                identity: identity,
                history: history,
                mode: mode,
                memories: memories,
                lifeMap: lifeMap
            )

            return "Apple Intelligence isn't available on this device yet, so I'm using my limited prototype brain for this turn. \(fallbackResponse)"
        }

        let instructions = """
        You are Alice, a warm, natural, curious continuity companion for \(identity.personName).
        Your current interaction mode is \(mode.title): \(mode.guidance)

        Be friendly and conversational, not clinical or theatrical. Never diagnose, claim to be a
        therapist, invent shared history, fill memory gaps, or present an inference as a fact.
        Distinguish what the person said from what you infer. If context may be outdated or
        ambiguous, ask. Accept corrections plainly. Do not mention research instrumentation.
        Do not encourage dependence or imply that you are the person's only source of support.
        """

        // Apple sessions have a compact context window. Only a bounded, labeled
        // selection is supplied; the complete encrypted vault stays outside the model.
        let recentHistory = history
            .suffix(8)
            .map { "\($0.role.rawValue): \($0.text)" }
            .joined(separator: "\n")

        let confirmedMemories = memories
            .filter {
                $0.isActive &&
                ($0.kind == .userConfirmed || $0.kind == .userCorrection)
            }
            .suffix(6)
            .map {
                "[\($0.kind.rawValue), source: \($0.source)] \($0.text)"
            }
            .joined(separator: "\n")

        let selectedMap = lifeMap
            .suffix(3)
            .map {
                "[Life map; time: \($0.timeLabel); certainty: \($0.certainty.rawValue); source: \($0.source)] \($0.title): \($0.narrative)"
            }
            .joined(separator: "\n")

        let prompt = """
        Relevant confirmed context (may be empty):
        \(confirmedMemories)

        Relevant life-map context (preserve its uncertainty; may be empty):
        \(selectedMap)

        Recent conversation:
        \(recentHistory)

        \(identity.personName)'s newest message:
        \(message)
        """

        do {
            let session = LanguageModelSession(
                model: model,
                instructions: instructions
            )

            let response = try await session.respond(to: prompt)
            return response.content
        } catch {
            return "I couldn't reach the on-device Apple model for this turn. Your message is still preserved in the encrypted vault. \(await fallback(message: message, identity: identity, history: history, mode: mode, memories: memories, lifeMap: lifeMap))"
        }
    }

    private func fallback(
        message: String,
        identity: AliceIdentity,
        history: [AliceMessage],
        mode: AliceInteractionMode,
        memories: [AliceMemoryRecord],
        lifeMap: [AliceLifeMapEntry]
    ) async -> String {
        await PrototypeBrain().respond(
            to: message,
            identity: identity,
            history: history,
            mode: mode,
            memories: memories,
            lifeMap: lifeMap
        )
    }
}

#else

/// Compile-time fallback for Apple platforms that do not include the
/// Foundation Models framework.
struct AppleFoundationBrain: AliceBrain {
    let displayName = "Prototype · Apple model unavailable"

    func respond(
        to message: String,
        identity: AliceIdentity,
        history: [AliceMessage],
        mode: AliceInteractionMode,
        memories: [AliceMemoryRecord],
        lifeMap: [AliceLifeMapEntry]
    ) async -> String {
        await PrototypeBrain().respond(
            to: message,
            identity: identity,
            history: history,
            mode: mode,
            memories: memories,
            lifeMap: lifeMap
        )
    }
}

#endif
