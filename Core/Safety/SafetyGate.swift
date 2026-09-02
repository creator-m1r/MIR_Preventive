import Foundation

public enum SafetyDecision: Sendable, Equatable {
    case allow
    case recheck
    case insufficientData
    case medicalReview
}

public struct SafetyContext: Sendable {
    public let observations: [Observation]
    public let contradictions: [String]
    public let modelVersion: String

    public init(
        observations: [Observation],
        contradictions: [String] = [],
        modelVersion: String
    ) {
        self.observations = observations
        self.contradictions = contradictions
        self.modelVersion = modelVersion
    }
}

public struct SafetyGate: Sendable {
    public init() {}

    public func evaluate(_ context: SafetyContext) -> SafetyDecision {
        guard !context.observations.isEmpty else {
            return .insufficientData
        }

        if context.observations.contains(where: {
            $0.qualityReport.state == .invalid ||
            $0.qualityReport.state == .missing
        }) {
            return .insufficientData
        }

        if context.observations.contains(where: {
            $0.qualityReport.state == .lowQuality ||
            $0.qualityReport.state == .repeatRequired
        }) {
            return .recheck
        }

        if !context.contradictions.isEmpty {
            return .recheck
        }

        guard !context.modelVersion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .insufficientData
        }

        return .allow
    }
}
