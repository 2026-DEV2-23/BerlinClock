import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds")
    func secondsLampIsOnForEvenSeconds() {
        let seconds = 20
        let original = engine.isSecondsLampOn(seconds: seconds)
        #expect(original == true, "Failed at seconds \(seconds)")
    }
}
