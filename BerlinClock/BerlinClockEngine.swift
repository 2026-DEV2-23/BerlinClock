class BerlinClockEngine {
    
    func convertHoursMinutesAndSecondsToLamp(time: DigitalTime) -> BerlinClockLamp {
        BerlinClockLamp(
            secondsLamp: secondsToLamp(seconds: time.seconds),
            fiveHoursLamp: fiveHoursToLamp(hours: time.hours),
            oneHourLamp: oneHourToLamp(hours: time.hours),
            fiveMinutesLamp: fiveMinutesToLamp(minutes: time.minutes),
            oneMinuteLamp: oneMinuteToLamp(minutes: time.minutes)
        )
    }
    
    private func secondsToLamp(seconds: UInt) -> LampState {
        return seconds % 2 == 0 ? .red : .off
    }
    
    private func fiveHoursToLamp(hours: UInt) -> [LampState] {
        let lamps = hours / 5
        return (0..<4).map { $0 < lamps ? .red : .off }
    }
    
    private func oneHourToLamp(hours: UInt) -> [LampState] {
        let lamps = hours % 5
        return (0..<4).map { $0 < lamps ? .red : .off }
    }
    
    private func fiveMinutesToLamp(minutes: UInt) -> [LampState] {
        let lamps = minutes / 5
        return (0..<11).map {
            if $0 < lamps {
                return ($0 + 1) % 3 == 0 ? .red : .yellow
            }
            return .off
        }
    }
    
    private func oneMinuteToLamp(minutes: UInt) -> [LampState] {
        let lamps = minutes % 5
        return (0..<4).map { $0 < lamps ? .yellow : .off }
    }
    
}

struct DigitalTime {
    let hours: UInt
    let minutes: UInt
    let seconds: UInt
    
    init(hours: UInt, minutes: UInt, seconds: UInt) throws {
        guard (0...23).contains(hours) else {
            throw TimeValidationError.invalidHours(hours)
        }
        guard (0...59).contains(minutes) else {
            throw TimeValidationError.invalidMinutes(minutes)
        }
        guard (0...59).contains(seconds) else {
            throw TimeValidationError.invalidSeconds(seconds)
        }
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }

}

struct BerlinClockLamp {
    let secondsLamp: LampState
    let fiveHoursLamp: [LampState]
    let oneHourLamp: [LampState]
    let fiveMinutesLamp: [LampState]
    let oneMinuteLamp: [LampState]
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
