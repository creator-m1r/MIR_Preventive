import Foundation

public typealias EntityID = UUID

public enum QualityState: String, Codable, Sendable {
    case valid
    case lowQuality
    case repeatRequired
    case missing
    case invalid
}

public struct Measurement: Codable, Sendable, Identifiable {
    public let id: EntityID
    public let metric: String
    public let value: Double
    public let unit: String
    public let capturedAt: Date
    public let sourceID: String
    public let methodVersion: String
    public let quality: QualityState

    public init(
        id: EntityID = UUID(),
        metric: String,
        value: Double,
        unit: String,
        capturedAt: Date = .now,
        sourceID: String,
        methodVersion: String,
        quality: QualityState = .valid
    ) {
        self.id = id
        self.metric = metric
        self.value = value
        self.unit = unit
        self.capturedAt = capturedAt
        self.sourceID = sourceID
        self.methodVersion = methodVersion
        self.quality = quality
    }
}

public struct QualityReport: Codable, Sendable {
    public let state: QualityState
    public let score: Double?
    public let reasons: [String]

    public init(state: QualityState, score: Double? = nil, reasons: [String] = []) {
        self.state = state
        self.score = score
        self.reasons = reasons
    }
}

public struct Observation: Codable, Sendable, Identifiable {
    public let id: EntityID
    public let personID: EntityID
    public let measurement: Measurement
    public let qualityReport: QualityReport
    public let provenance: String

    public init(
        id: EntityID = UUID(),
        personID: EntityID,
        measurement: Measurement,
        qualityReport: QualityReport,
        provenance: String
    ) {
        self.id = id
        self.personID = personID
        self.measurement = measurement
        self.qualityReport = qualityReport
        self.provenance = provenance
    }
}

public struct Trend: Codable, Sendable, Identifiable {
    public let id: EntityID
    public let metric: String
    public let slope: Double
    public let observationIDs: [EntityID]
    public let confidence: Double?
    public let modelVersion: String

    public init(
        id: EntityID = UUID(),
        metric: String,
        slope: Double,
        observationIDs: [EntityID],
        confidence: Double? = nil,
        modelVersion: String
    ) {
        self.id = id
        self.metric = metric
        self.slope = slope
        self.observationIDs = observationIDs
        self.confidence = confidence
        self.modelVersion = modelVersion
    }
}

public enum RiskSeverity: String, Codable, Sendable {
    case info
    case monitor
    case recheck
    case additionalAssessment
    case medicalReview
    case urgentEscalation
}

public struct RiskSignal: Codable, Sendable, Identifiable {
    public let id: EntityID
    public let category: String
    public let severity: RiskSeverity
    public let evidenceIDs: [EntityID]
    public let confidence: Double?
    public let uncertainty: String?
    public let modelVersion: String

    public init(
        id: EntityID = UUID(),
        category: String,
        severity: RiskSeverity,
        evidenceIDs: [EntityID],
        confidence: Double? = nil,
        uncertainty: String? = nil,
        modelVersion: String
    ) {
        self.id = id
        self.category = category
        self.severity = severity
        self.evidenceIDs = evidenceIDs
        self.confidence = confidence
        self.uncertainty = uncertainty
        self.modelVersion = modelVersion
    }
}

public struct Recommendation: Codable, Sendable, Identifiable {
    public let id: EntityID
    public let action: String
    public let reason: String
    public let evidenceIDs: [EntityID]
    public let limitations: [String]

    public init(
        id: EntityID = UUID(),
        action: String,
        reason: String,
        evidenceIDs: [EntityID] = [],
        limitations: [String] = []
    ) {
        self.id = id
        self.action = action
        self.reason = reason
        self.evidenceIDs = evidenceIDs
        self.limitations = limitations
    }
}

public struct Referral: Codable, Sendable, Identifiable {
    public let id: EntityID
    public let reason: String
    public let requestedAssessment: String
    public let evidenceIDs: [EntityID]

    public init(
        id: EntityID = UUID(),
        reason: String,
        requestedAssessment: String,
        evidenceIDs: [EntityID] = []
    ) {
        self.id = id
        self.reason = reason
        self.requestedAssessment = requestedAssessment
        self.evidenceIDs = evidenceIDs
    }
}

public struct Consent: Codable, Sendable, Identifiable {
    public let id: EntityID
    public let personID: EntityID
    public let scope: String
    public let grantedAt: Date
    public let expiresAt: Date?
    public let revokedAt: Date?

    public init(
        id: EntityID = UUID(),
        personID: EntityID,
        scope: String,
        grantedAt: Date = .now,
        expiresAt: Date? = nil,
        revokedAt: Date? = nil
    ) {
        self.id = id
        self.personID = personID
        self.scope = scope
        self.grantedAt = grantedAt
        self.expiresAt = expiresAt
        self.revokedAt = revokedAt
    }
}

public struct AuditEvent: Codable, Sendable, Identifiable {
    public let id: EntityID
    public let eventType: String
    public let timestamp: Date
    public let actor: String
    public let entityID: EntityID?
    public let metadata: [String: String]

    public init(
        id: EntityID = UUID(),
        eventType: String,
        timestamp: Date = .now,
        actor: String,
        entityID: EntityID? = nil,
        metadata: [String: String] = [:]
    ) {
        self.id = id
        self.eventType = eventType
        self.timestamp = timestamp
        self.actor = actor
        self.entityID = entityID
        self.metadata = metadata
    }
}
