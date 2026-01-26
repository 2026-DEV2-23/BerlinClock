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
    
    func fiveMinutesToLamp(minutes: UInt) throws -> [LampState] {
        guard (0...59).contains(minutes) else {
            throw TimeValidationError.invalidMinutes(minutes)
        }
        let lamps = minutes / 5
        return (0..<11).map {
            if $0 < lamps {
                return ($0 + 1) % 3 == 0 ? .red : .yellow
            }
            return .off
        }
    }
    
    func oneMinuteToLamp(minutes: UInt) throws -> [LampState] {
        guard (0...59).contains(minutes) else {
            throw TimeValidationError.invalidMinutes(minutes)
        }
        switch minutes {
        case 1, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56:
            return [.yellow, .off, .off, .off]
        case 2, 7, 12, 17, 22, 27, 32, 37, 42, 47, 52, 57:
            return [.yellow, .yellow, .off, .off]
        case 3, 8, 13, 18, 23, 28, 33, 38, 43, 48, 53, 58:
            return [.yellow, .yellow, .yellow, .off]
        case 4, 9, 14, 19, 24, 29, 34, 39, 44, 49, 54, 59:
            return [.yellow, .yellow, .yellow, .yellow]
        default:
            return [.off, .off, .off, .off]
        }
    }

}

enum TimeValidationError: Error, Equatable {
    case invalidSeconds(UInt)
    case invalidHours(UInt)
    case invalidMinutes(UInt)
    
    var localizedDescription: String {
        switch self {
        case .invalidSeconds(let seconds):
            return "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
        case .invalidHours(let hours):
            return "Invalid hours: \(hours). Hours must be between 0 and 23."
        case .invalidMinutes(let minutes):
            return "Invalid minutes: \(minutes). Minutes must be between 0 and 59."
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
