class BerlinClockEngine {
    
    func secondsLamps(seconds: UInt) throws -> LampState {
        guard (0...59).contains(seconds) else {
            throw TimeValidationError.invalidSeconds(seconds)
        }
        return seconds % 2 == 0 ? .on : .off
    }
    
    func fiveHoursToLamp(hours: UInt) -> [LampState] {
        switch hours {
        case 5, 6, 7, 8, 9:
            return [.on, .off, .off, .off]
        case 10, 11, 12, 13, 14:
            return [.on, .on, .off, .off]
        case 15:
            return [.on, .on, .on, .off]
        case 20:
            return [.on, .on, .on, .on]
        default:
            return [.off, .off, .off, .off]
        }
    }

}

enum TimeValidationError: Error, Equatable {
    case invalidSeconds(UInt)
    
    var localizedDescription: String {
        switch self {
        case .invalidSeconds(let seconds):
            return "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
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
