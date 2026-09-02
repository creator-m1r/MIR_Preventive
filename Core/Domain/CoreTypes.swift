import Foundation

public enum DataState: String, Codable, Sendable {
    case observed
    case derived
    case trend
    case riskSignal
    case recommendation
    case referral
    case insufficientData
}

public struct ModelVersion: Codable, Sendable, Hashable {
    public let identifier: String
    public let version: String

    public init(identifier: String, version: String) {
        self.identifier = identifier
        self.version = version
    }
}

public struct EvidenceReference: Codable, Sendable, Hashable {
    public let id: EntityID
    public let state: DataState

    public init(id: EntityID, state: DataState) {
        self.id = id
        self.state = state
    }
}
