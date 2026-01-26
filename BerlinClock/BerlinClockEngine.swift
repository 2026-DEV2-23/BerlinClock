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
        switch hours {
        case 5, 6, 7, 8, 9:
            return [.on, .off, .off, .off]
        case 10, 11, 12, 13, 14:
            return [.on, .on, .off, .off]
        case 15, 16, 17, 18, 19:
            return [.on, .on, .on, .off]
        case 20, 21, 22, 23:
            return [.on, .on, .on, .on]
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
