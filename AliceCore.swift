import AVFoundation
import Combine
import Foundation

struct AliceMessage: Identifiable, Codable, Equatable {
    enum Role: String, Codable { case user, alice }

    let id: UUID
    let role: Role
    let text: String
    let createdAt: Date

    init(role: Role, text: String) {
        id = UUID()
        self.role = role
        self.text = text
        createdAt = Date()
    }
}

struct AliceIdentity: Codable {
    var name = "Alice"
    var personName = "User"
    var guidingLine = "Same mind. Different places. Always with you."
    var personality = "Warm, observant, curious, honest, funny, and never blindly agreeable."
    var memories: [String] = [] // Prototype 3 compatibility
}

enum AlicePresenceMode: String, CaseIterable, Identifiable, Codable {
    case observe, standby, off

    var id: String { rawValue }
    var title: String { rawValue.capitalized }

    var detail: String {
        switch self {
        case .observe:
            "Alice may offer visible, test-only check-ins while the app is open."
        case .standby:
            "Alice stays available but waits for you."
        case .off:
            "Alice is dismissed until you turn her back on."
        }
    }
}

enum AliceInteractionMode: String, CaseIterable, Identifiable, Codable {
    case reflect, explore, rehearse, repair, journal

    var id: String { rawValue }
    var title: String { rawValue.capitalized }

    var icon: String {
        switch self {
        case .reflect: "sparkles"
        case .explore: "safari"
        case .rehearse: "person.2.wave.2"
        case .repair: "arrow.triangle.2.circlepath"
        case .journal: "book.closed"
        }
    }

    var guidance: String {
        switch self {
        case .reflect:
            "Mirror what is present without diagnosing or deciding what it means."
        case .explore:
            "Ask careful questions and keep multiple explanations possible."
        case .rehearse:
            "Practice clearer communication without speaking for the other person."
        case .repair:
            "Name misunderstandings, accept corrections, and help try again."
        case .journal:
            "Capture the person's own words without turning them into conclusions."
        }
    }
}

enum AliceMemoryKind: String, CaseIterable, Codable {
    case userConfirmed = "User confirmed"
    case userCorrection = "User correction"
    case aliceObservation = "Alice observation"
    case workingHypothesis = "Working hypothesis"
}

struct AliceMemoryRecord: Identifiable, Codable, Equatable {
    let id: UUID
    var kind: AliceMemoryKind
    var text: String
    var source: String
    var confidence: Double
    let createdAt: Date
    var revisedFrom: UUID?
    var isActive: Bool

    init(
        kind: AliceMemoryKind,
        text: String,
        source: String = "Direct user request",
        confidence: Double = 1,
        revisedFrom: UUID? = nil
    ) {
        id = UUID()
        self.kind = kind
        self.text = text
        self.source = source
        self.confidence = confidence
        createdAt = Date()
        self.revisedFrom = revisedFrom
        isActive = true
    }
}

enum AliceCertainty: String, CaseIterable, Identifiable, Codable {
    case clear = "Clear"
    case approximate = "Approximate"
    case uncertain = "Uncertain"
    case unknown = "Unknown"

    var id: String { rawValue }
}

struct AliceLifeMapEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var timeLabel: String
    var narrative: String
    var certainty: AliceCertainty
    var source: String
    var meaningNow: String
    var discussWithTherapist: Bool
    let createdAt: Date
    var revisedFrom: UUID?

    init(
        title: String,
        timeLabel: String,
        narrative: String,
        certainty: AliceCertainty,
        source: String = "Personal recollection",
        meaningNow: String = "",
        discussWithTherapist: Bool = false,
        revisedFrom: UUID? = nil
    ) {
        id = UUID()
        self.title = title
        self.timeLabel = timeLabel
        self.narrative = narrative
        self.certainty = certainty
        self.source = source
        self.meaningNow = meaningNow
        self.discussWithTherapist = discussWithTherapist
        createdAt = Date()
        self.revisedFrom = revisedFrom
    }
}

enum AliceResearchEventKind: String, Codable {
    case sessionInput
    case aliceResponse
    case memorySaved
    case lifeMapCreated
    case exportCreated
    case correction
}

struct AliceResearchEvent: Identifiable, Codable, Equatable {
    let id: UUID
    let kind: AliceResearchEventKind
    let createdAt: Date
    let interactionMode: AliceInteractionMode
    let detail: String
    let brainName: String

    init(
        kind: AliceResearchEventKind,
        mode: AliceInteractionMode,
        detail: String,
        brainName: String
    ) {
        id = UUID()
        self.kind = kind
        createdAt = Date()
        interactionMode = mode
        self.detail = detail
        self.brainName = brainName
    }
}

struct AliceResearchExport: Codable {
    let exportVersion: Int
    let exportedAt: Date
    let researchNote: String
    let identity: AliceIdentity
    let messages: [AliceMessage]
    let memories: [AliceMemoryRecord]
    let lifeMap: [AliceLifeMapEntry]
    let events: [AliceResearchEvent]
}

protocol AliceBrain {
    var displayName: String { get }

    func respond(
        to message: String,
        identity: AliceIdentity,
        history: [AliceMessage],
        mode: AliceInteractionMode,
        memories: [AliceMemoryRecord],
        lifeMap: [AliceLifeMapEntry]
    ) async -> String
}

struct PrototypeBrain: AliceBrain {
    let displayName = "Prototype · On device"

    func respond(
        to message: String,
        identity: AliceIdentity,
        history: [AliceMessage],
        mode: AliceInteractionMode,
        memories: [AliceMemoryRecord],
        lifeMap: [AliceLifeMapEntry]
    ) async -> String {
        let text = message.lowercased()

        if text.contains("who are you") {
            return "I'm Alice. I can keep continuity and help you reflect, but I won't diagnose you or pretend an interpretation is a fact."
        }

        if text.contains("what do you remember") {
            return memories.isEmpty
                ? "My encrypted memory is empty. You decide what becomes a confirmed memory."
                : "I have \(memories.filter(\.isActive).count) active, labeled memories. I should still ask before treating any interpretation as true."
        }

        if text.contains("hello") || text.contains("hi") {
            return "Hey, \(identity.personName). Do you want reflection, exploration, practice, repair, or simply a place to write?"
        }

        if text.contains("research") {
            return "We can preserve what happened, what context I received, and what changed—without pretending that one result proves the theory."
        }

        switch mode {
        case .reflect:
            return "What I hear is: \(message)\n\nWhat part of that feels most important to hold onto?"
        case .explore:
            return "There may be more than one way to understand this. What do you know directly, and what part are you still trying to make sense of?"
        case .rehearse:
            return "Let's practice it in your voice. What do you want the other person to understand, and what do you want to avoid assuming about them?"
        case .repair:
            return "Let's slow the misunderstanding down. What did you mean, what seems to have been heard, and what would a fair second attempt sound like?"
        case .journal:
            return "I've kept your words in this session. You don't have to decide what they mean yet."
        }
    }
}

@MainActor
final class AliceSession: ObservableObject {
    @Published var messages: [AliceMessage] {
        didSet { saveVault() }
    }

    @Published var memoryRecords: [AliceMemoryRecord] {
        didSet { saveVault() }
    }

    @Published var lifeMap: [AliceLifeMapEntry] {
        didSet { saveVault() }
    }

    @Published var researchEvents: [AliceResearchEvent] {
        didSet { saveVault() }
    }

    @Published var interactionMode: AliceInteractionMode {
        didSet {
            UserDefaults.standard.set(
                interactionMode.rawValue,
                forKey: "alice.interaction-mode"
            )
        }
    }

    @Published var draft = ""
    @Published var isThinking = false
    @Published var isSpeaking = false

    @Published var voiceEnabled: Bool {
        didSet {
            UserDefaults.standard.set(
                voiceEnabled,
                forKey: "alice.voice-enabled"
            )
        }
    }

    @Published var pendingChime: String?

    @Published var presence: AlicePresenceMode {
        didSet {
            UserDefaults.standard.set(
                presence.rawValue,
                forKey: "alice.presence"
            )
            configurePresence()
        }
    }

    private(set) var identity: AliceIdentity {
        didSet { saveVault() }
    }

    private var brain: any AliceBrain = AppleFoundationBrain()
    private let speaker = AVSpeechSynthesizer()
    private let vault = AliceMemoryVault()
    private var presenceTask: Task<Void, Never>?
    private var isRestoring = true

    var brainName: String { brain.displayName }
    var memoryCount: Int { memoryRecords.filter(\.isActive).count }

    init() {
        let restored = vault.load()

        identity = restored?.identity ?? AliceIdentity()

        messages = restored?.messages ?? [
            AliceMessage(role: .alice, text: "Hey."),
            AliceMessage(role: .alice, text: "I'm here. What’s on your mind?")
        ]

        memoryRecords =
            restored?.memoryRecords
            ?? (restored?.identity.memories ?? []).map {
                AliceMemoryRecord(
                    kind: .userConfirmed,
                    text: $0,
                    source: "Imported from Prototype 3"
                )
            }

        lifeMap = restored?.lifeMap ?? []
        researchEvents = restored?.researchEvents ?? []

        interactionMode =
            AliceInteractionMode(
                rawValue: UserDefaults.standard.string(
                    forKey: "alice.interaction-mode"
                ) ?? ""
            ) ?? .reflect

        presence =
            AlicePresenceMode(
                rawValue: UserDefaults.standard.string(
                    forKey: "alice.presence"
                ) ?? ""
            ) ?? .standby

        voiceEnabled =
            UserDefaults.standard.object(
                forKey: "alice.voice-enabled"
            ) == nil
            ? true
            : UserDefaults.standard.bool(
                forKey: "alice.voice-enabled"
            )

        isRestoring = false
        configurePresence()
    }

    func send() {
        let outgoing = draft.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !outgoing.isEmpty, !isThinking else { return }

        draft = ""
        messages.append(
            AliceMessage(role: .user, text: outgoing)
        )

        record(.sessionInput, detail: outgoing)
        isThinking = true

        if let memory = memoryRequest(in: outgoing) {
            memoryRecords.append(
                AliceMemoryRecord(
                    kind: .userConfirmed,
                    text: memory
                )
            )

            record(
                .memorySaved,
                detail: "User-confirmed memory saved: \(memory)"
            )

            let acknowledgement =
                "I’ll remember that as something you directly confirmed. It is labeled and stored in my encrypted vault."

            messages.append(
                AliceMessage(
                    role: .alice,
                    text: acknowledgement
                )
            )

            speak(acknowledgement)
            isThinking = false
            return
        }

        Task {
            let response = await brain.respond(
                to: outgoing,
                identity: identity,
                history: messages,
                mode: interactionMode,
                memories: memoryRecords.filter(\.isActive),
                lifeMap: lifeMap
            )

            messages.append(
                AliceMessage(role: .alice, text: response)
            )

            record(.aliceResponse, detail: response)
            isThinking = false
            speak(response)
        }
    }

    func addLifeMapEntry(
        title: String,
        timeLabel: String,
        narrative: String,
        certainty: AliceCertainty,
        meaningNow: String,
        discussWithTherapist: Bool
    ) {
        lifeMap.append(
            AliceLifeMapEntry(
                title: title,
                timeLabel: timeLabel,
                narrative: narrative,
                certainty: certainty,
                meaningNow: meaningNow,
                discussWithTherapist: discussWithTherapist
            )
        )

        record(
            .lifeMapCreated,
            detail:
                "Life-map entry created: \(title) (\(certainty.rawValue))"
        )
    }

    func exportResearchBundle() -> URL? {
        let export = AliceResearchExport(
            exportVersion: 1,
            exportedAt: Date(),
            researchNote:
                "Exploratory single-participant record. Not a diagnosis or clinical conclusion.",
            identity: identity,
            messages: messages,
            memories: memoryRecords,
            lifeMap: lifeMap,
            events: researchEvents
        )

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601

        guard let data = try? encoder.encode(export) else {
            return nil
        }

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                "Pocket-Alice-Research-Export.json"
            )

        do {
            try data.write(
                to: url,
                options: [.atomic, .completeFileProtection]
            )

            record(
                .exportCreated,
                detail: "User created a research export"
            )

            return url
        } catch {
            return nil
        }
    }

    func offerTestChime() {
        guard presence == .observe else { return }

        pendingChime = [
            "A thought: we don’t have to finish everything at once. Want to pick one small thing?",
            "I’m here if you want to capture what you’re thinking before it disappears.",
            "Gentle check-in: do you want company, help, or quiet right now?"
        ].randomElement()
    }

    func dismissChime() {
        pendingChime = nil
    }

    private func memoryRequest(in text: String) -> String? {
        let lower = text.lowercased()

        guard let range = lower.range(of: "remember that") else {
            return nil
        }

        let memory = text[range.upperBound...]
            .trimmingCharacters(in: .whitespacesAndNewlines)

        return memory.isEmpty ? nil : memory
    }

    private func record(
        _ kind: AliceResearchEventKind,
        detail: String
    ) {
        researchEvents.append(
            AliceResearchEvent(
                kind: kind,
                mode: interactionMode,
                detail: detail,
                brainName: brain.displayName
            )
        )
    }

    private func saveVault() {
        guard !isRestoring else { return }

        vault.save(
            AliceVaultPayload(
                identity: identity,
                messages: messages,
                memoryRecords: memoryRecords,
                lifeMap: lifeMap,
                researchEvents: researchEvents
            )
        )
    }

    private func configurePresence() {
        presenceTask?.cancel()
        presenceTask = nil
        pendingChime = nil

        guard presence == .observe else { return }

        presenceTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(45))

                guard !Task.isCancelled else { return }

                self?.offerTestChime()
            }
        }
    }

    func speakLatest() {
        guard
            let text = messages.last(
                where: { $0.role == .alice }
            )?.text
        else {
            return
        }

        if speaker.isSpeaking {
            speaker.stopSpeaking(at: .immediate)
            isSpeaking = false
            return
        }

        speak(text, force: true)
    }

    private func speak(
        _ text: String,
        force: Bool = false
    ) {
        guard voiceEnabled || force else { return }

        if speaker.isSpeaking {
            speaker.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.48
        utterance.pitchMultiplier = 1.05
        utterance.volume = 1
        utterance.voice =
            AVSpeechSynthesisVoice(language: "en-US")

        speaker.speak(utterance)
        isSpeaking = true
    }
}
