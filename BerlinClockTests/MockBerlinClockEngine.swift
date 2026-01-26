import Testing
@testable import BerlinClock

class MockBerlinClockEngine: BerlinClockEngineProtocol {
    
    func convertDigitalTimeToLamp(time: DigitalTime) -> BerlinClockLamp {
        switch (time.hours, time.minutes, time.seconds) {
        case (8, 23, 2):
            return morningBerlinClockLamp
        case (15, 37, 55):
            return afternoonBerlinClockLamp
        case (19, 44, 45):
            return eveningBerlinClockLamp
        case (23, 59, 59):
            return endOfDayBerlinClockLamp
        default:
            return BerlinClockLamp.empty
        }
    }
    
    private var morningBerlinClockLamp: BerlinClockLamp {
        BerlinClockLamp(
            secondsLamp: .red,
            fiveHoursLamp: [.red, .off, .off, .off],
            oneHourLamp: [.red, .red, .red, .off],
            fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .off, .off, .off, .off, .off, .off, .off],
            oneMinuteLamp: [.yellow, .yellow, .yellow, .off]
        )
    }
    
    private var afternoonBerlinClockLamp: BerlinClockLamp {
        BerlinClockLamp(
            secondsLamp: .off,
            fiveHoursLamp: [.red, .red, .red, .off],
            oneHourLamp: [.off, .off, .off, .off],
            fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off, .off, .off, .off],
            oneMinuteLamp: [.yellow, .yellow, .off, .off]
        )
    }
    
    private var eveningBerlinClockLamp: BerlinClockLamp {
        BerlinClockLamp(
            secondsLamp: .off,
            fiveHoursLamp: [.red, .red, .red, .off],
            oneHourLamp: [.red, .red, .red, .red],
            fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .off, .off, .off],
            oneMinuteLamp: [.yellow, .yellow, .yellow, .yellow]
        )
    }
    
    private var endOfDayBerlinClockLamp: BerlinClockLamp {
        BerlinClockLamp(
            secondsLamp: .off,
            fiveHoursLamp: [.red, .red, .red, .red],
            oneHourLamp: [.red, .red, .red, .off],
            fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow],
            oneMinuteLamp: [.yellow, .yellow, .yellow, .yellow]
        )
    }
}
