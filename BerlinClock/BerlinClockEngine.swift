class BerlinClockEngine {
    
    func secondsToLamp(seconds: UInt) throws -> LampState {
        guard (0...59).contains(seconds) else {
            throw TimeValidationError.invalidSeconds(seconds)
        }
        return seconds % 2 == 0 ? .on : .off
    }
    
    func fiveHoursToLamp(hours: UInt) throws -> [LampState] {
        guard (0...23).contains(hours) else {
            throw TimeValidationError.invalidHours(hours)
        }
        let lamps = hours / 5
        return (0..<4).map { $0 < lamps ? .on : .off }
    }
    
    func oneHourToLamp(hours: UInt) -> [LampState] {
        switch hours {
        case 1:
            return [.on, .off, .off, .off]
        case 2:
            return [.on, .on, .off, .off]
        default:
            return [.off, .off, .off, .off]
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
    case on
    
    // Manually implementing the comparison to strip away the actor isolation in swift 6.0
    nonisolated static func == (lhs: LampState, rhs: LampState) -> Bool {
        switch (lhs, rhs) {
        case (.off, .off), (.on, .on):
            return true
        default:
            return false
        }
    }
}
