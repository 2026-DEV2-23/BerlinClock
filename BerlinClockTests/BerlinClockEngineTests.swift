import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds", arguments: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58])
    func secondsLampIsOnForEvenSeconds(seconds: Int) {
        let original = engine.isSecondsLampOn(seconds: seconds)
        #expect(original == true, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp is off for odd seconds")
    func secondsLampIsOffForEvenSeconds() {
        let seconds = 21
        let original = engine.isSecondsLampOn(seconds: seconds)
        #expect(original == false, "Failed at seconds \(seconds)")
    }
}
