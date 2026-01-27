struct BerlinClockLamp: Equatable {
    let secondsLamp: LampState
    let fiveHoursLamp: [LampState]
    let oneHourLamp: [LampState]
    let fiveMinutesLamp: [LampState]
    let oneMinuteLamp: [LampState]
    
    static let empty = BerlinClockLamp(
        secondsLamp: .off,
        fiveHoursLamp: Array(repeating: .off, count: 4),
        oneHourLamp:  Array(repeating: .off, count: 4),
        fiveMinutesLamp: Array(repeating: .off, count: 11),
        oneMinuteLamp: Array(repeating: .off, count: 4)
    )
    
    // Manually implementing the comparison to strip away actor isolation
    nonisolated static func == (lhs: BerlinClockLamp, rhs: BerlinClockLamp) -> Bool {
        lhs.secondsLamp == rhs.secondsLamp &&
        lhs.fiveHoursLamp == rhs.fiveHoursLamp &&
        lhs.oneHourLamp == rhs.oneHourLamp &&
        lhs.fiveMinutesLamp == rhs.fiveMinutesLamp &&
        lhs.oneMinuteLamp == rhs.oneMinuteLamp
    }
}
