import Foundation

public protocol DomainEvent: Sendable {
    var eventID: UUID { get }
    var occurredAt: Date { get }
    var eventType: String { get }
}

public struct EventEnvelope: Sendable {
    public let eventID: UUID
    public let occurredAt: Date
    public let eventType: String
    public let payload: any DomainEvent

    public init(payload: any DomainEvent) {
        self.eventID = payload.eventID
        self.occurredAt = payload.occurredAt
        self.eventType = payload.eventType
        self.payload = payload
    }
}

public actor EventBus {
    public typealias Handler = @Sendable (EventEnvelope) async -> Void

    private var handlers: [String: [UUID: Handler]] = [:]

    public init() {}

    @discardableResult
    public func subscribe(
        to eventType: String,
        handler: @escaping Handler
    ) -> UUID {
        let token = UUID()
        handlers[eventType, default: [:]][token] = handler
        return token
    }

    public func unsubscribe(token: UUID, from eventType: String) {
        handlers[eventType]?[token] = nil
    }

    public func publish(_ event: any DomainEvent) async {
        let envelope = EventEnvelope(payload: event)
        let subscribers = handlers[event.eventType]?.values ?? [:].values
        for handler in subscribers {
            await handler(envelope)
        }
    }
}

public struct MeasurementCaptured: DomainEvent {
    public let eventID: UUID
    public let occurredAt: Date
    public let observationID: EntityID
    public let eventType = "MeasurementCaptured"

    public init(observationID: EntityID, occurredAt: Date = .now, eventID: UUID = UUID()) {
        self.observationID = observationID
        self.occurredAt = occurredAt
        self.eventID = eventID
    }
}

public struct ModelUpdated: DomainEvent {
    public let eventID: UUID
    public let occurredAt: Date
    public let personID: EntityID
    public let modelVersion: String
    public let eventType = "ModelUpdated"

    public init(personID: EntityID, modelVersion: String, occurredAt: Date = .now, eventID: UUID = UUID()) {
        self.personID = personID
        self.modelVersion = modelVersion
        self.occurredAt = occurredAt
        self.eventID = eventID
    }
}

public struct RiskSignalCreated: DomainEvent {
    public let eventID: UUID
    public let occurredAt: Date
    public let signalID: EntityID
    public let severity: RiskSeverity
    public let eventType = "RiskSignalCreated"

    public init(signalID: EntityID, severity: RiskSeverity, occurredAt: Date = .now, eventID: UUID = UUID()) {
        self.signalID = signalID
        self.severity = severity
        self.occurredAt = occurredAt
        self.eventID = eventID
    }
}
