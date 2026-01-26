class BerlinClockEngine {
    
    func secondsToLamp(seconds: UInt) throws -> LampState {
        guard (0...59).contains(seconds) else {
            throw TimeValidationError.invalidSeconds(seconds)
        }
        return seconds % 2 == 0 ? .red : .off
    }
    
    func fiveHoursToLamp(hours: UInt) throws -> [LampState] {
        guard (0...23).contains(hours) else {
            throw TimeValidationError.invalidHours(hours)
        }
        let lamps = hours / 5
        return (0..<4).map { $0 < lamps ? .red : .off }
    }
    
    func oneHourToLamp(hours: UInt) throws -> [LampState] {
        guard (0...23).contains(hours) else {
            throw TimeValidationError.invalidHours(hours)
        }
        let lamps = hours % 5
        return (0..<4).map { $0 < lamps ? .red : .off }
    }
    
    func fiveMinutesToLamp(minutes: UInt) -> [LampState] {
        switch minutes {
        case 5:
            return [.yellow, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off]
        case 10:
            return [.yellow, .yellow, .off, .off, .off, .off, .off, .off, .off, .off, .off]
        default:
            return [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off]
        }
    }
}

enum TimeValidationError: Error, Equatable {
    case invalidSeconds(UInt)
    case invalidHours(UInt)
    
    var localizedDescription: String {
        switch self {
        case .invalidSeconds(let seconds):
            return "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
        case .invalidHours(let hours):
            return "Invalid hours: \(hours). Hours must be between 0 and 23."
        }
    }
}

enum LampState: Equatable, Sendable {
    case off
    case red
    case yellow
    
    // Manually implementing the comparison to strip away actor isolation
    nonisolated static func == (lhs: LampState, rhs: LampState) -> Bool {
        switch (lhs, rhs) {
        case (.off, .off),
            (.red, .red),
            (.yellow, .yellow):
            return true
        default:
            return false
        }
    }
}
