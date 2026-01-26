import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds", arguments: Array(stride(from: 0, to: 60, by: 2)))
    func secondsLampIsOnForEvenSeconds(seconds: Int) {
        let original = engine.isSecondsLampOn(seconds: seconds)
        #expect(original == true, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp is off for odd seconds", arguments: Array(stride(from: 1, to: 60, by: 2)))
    func secondsLampIsOffForEvenSeconds(seconds: Int) {
        let original = engine.isSecondsLampOn(seconds: seconds)
        #expect(original == false, "Failed at seconds \(seconds)")
    }
}
