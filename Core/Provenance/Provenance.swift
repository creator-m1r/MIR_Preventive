import Foundation

public struct ProvenanceRecord: Codable, Sendable, Identifiable {
    public let id: UUID
    public let sourceID: String
    public let method: String
    public let methodVersion: String
    public let inputIDs: [EntityID]
    public let createdAt: Date

    public init(
        id: UUID = UUID(),
        sourceID: String,
        method: String,
        methodVersion: String,
        inputIDs: [EntityID] = [],
        createdAt: Date = .now
    ) {
        self.id = id
        self.sourceID = sourceID
        self.method = method
        self.methodVersion = methodVersion
        self.inputIDs = inputIDs
        self.createdAt = createdAt
    }
}

public protocol ProvenanceStore: Sendable {
    func append(_ record: ProvenanceRecord) async
    func record(for id: UUID) async -> ProvenanceRecord?
}

public actor InMemoryProvenanceStore: ProvenanceStore {
    private var records: [UUID: ProvenanceRecord] = [:]

    public init() {}

    public func append(_ record: ProvenanceRecord) async {
        records[record.id] = record
    }

    public func record(for id: UUID) async -> ProvenanceRecord? {
        records[id]
    }
}
