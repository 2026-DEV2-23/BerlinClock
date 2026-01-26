struct BerlinClockLamp {
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
}
