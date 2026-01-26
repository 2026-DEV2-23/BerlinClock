class BerlinClockEngine {
    
    func secondsLamps(seconds: UInt) throws -> LampState {
        if !(0...59).contains(seconds) {
            throw TimeValidationError.invalidSeconds(seconds)
        }
        return seconds % 2 == 0 ? .on : .off
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
