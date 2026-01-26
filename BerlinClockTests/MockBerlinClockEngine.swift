import Testing
@testable import BerlinClock

class MockBerlinClockEngine: BerlinClockEngineProtocol {
    
    func convertDigitalTimeToLamp(time: BerlinClock.DigitalTime) -> BerlinClockLamp {
        switch (time.hours, time.minutes, time.seconds) {
            default :
            BerlinClockLamp.empty
        }
    }
}
