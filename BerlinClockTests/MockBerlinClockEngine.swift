import Testing
@testable import BerlinClock

class MockBerlinClockEngine: BerlinClockEngineProtocol {
    
    func convertDigitalTimeToLamp(time: DigitalTime) -> BerlinClockLamp {
        switch (time.hours, time.minutes, time.seconds) {
        case (8, 23, 2):
            return BerlinClockLamp(
                secondsLamp: .red,
                fiveHoursLamp: [.red, .off, .off, .off],
                oneHourLamp: [.red, .red, .red, .off],
                fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .off, .off, .off, .off, .off, .off, .off],
                oneMinuteLamp: [.yellow, .yellow, .yellow, .off]
            )
        default:
            return BerlinClockLamp.empty
        }
    }
}
