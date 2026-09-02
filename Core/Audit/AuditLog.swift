import Foundation

public protocol AuditLog: Sendable {
    func append(_ event: AuditEvent) async
}

public actor InMemoryAuditLog: AuditLog {
    private var events: [AuditEvent] = []

    public init() {}

    public func append(_ event: AuditEvent) async {
        events.append(event)
    }

    public func allEvents() async -> [AuditEvent] {
        events
    }
}
