import CryptoKit
import Foundation
import Security

struct AliceVaultPayload: Codable {
    var identity: AliceIdentity
    var messages: [AliceMessage]
    var memoryRecords: [AliceMemoryRecord]?
    var lifeMap: [AliceLifeMapEntry]?
    var researchEvents: [AliceResearchEvent]?

    init(
        identity: AliceIdentity,
        messages: [AliceMessage],
        memoryRecords: [AliceMemoryRecord]? = nil,
        lifeMap: [AliceLifeMapEntry]? = nil,
        researchEvents: [AliceResearchEvent]? = nil
    ) {
        self.identity = identity
        self.messages = messages
        self.memoryRecords = memoryRecords
        self.lifeMap = lifeMap
        self.researchEvents = researchEvents
    }
}

/// Stores Alice's personal continuity as encrypted data. The encryption key is
/// held in the Apple Keychain, never in the project or the vault file.
final class AliceMemoryVault {
    private let service = "com.Alice.Pocket-Alice.identity-vault"
    private let account = "alice-primary"
    private let fileURL: URL

    init() {
        let base = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        )[0]

        let directory = base.appendingPathComponent(
            "PocketAlice",
            isDirectory: true
        )

        try? FileManager.default.createDirectory(
            at: directory,
            withIntermediateDirectories: true
        )

        fileURL = directory.appendingPathComponent("AliceIdentity.vault")
    }

    func load() -> AliceVaultPayload? {
        guard
            let encrypted = try? Data(contentsOf: fileURL),
            let box = try? AES.GCM.SealedBox(combined: encrypted),
            let clear = try? AES.GCM.open(box, using: key()),
            let payload = try? JSONDecoder().decode(
                AliceVaultPayload.self,
                from: clear
            )
        else {
            return nil
        }

        return payload
    }

    func save(_ payload: AliceVaultPayload) {
        guard
            let clear = try? JSONEncoder().encode(payload),
            let sealed = try? AES.GCM.seal(clear, using: key()),
            let combined = sealed.combined
        else {
            return
        }

        try? combined.write(
            to: fileURL,
            options: [.atomic, .completeFileProtection]
        )
    }

    private func key() -> SymmetricKey {
        let lookup: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?

        if SecItemCopyMatching(
            lookup as CFDictionary,
            &item
        ) == errSecSuccess,
           let data = item as? Data {
            return SymmetricKey(data: data)
        }

        let newKey = SymmetricKey(size: .bits256)
        let data = newKey.withUnsafeBytes { Data($0) }

        let add: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessible as String:
                kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]

        SecItemAdd(add as CFDictionary, nil)

        return newKey
    }
}
