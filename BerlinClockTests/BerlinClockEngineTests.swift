import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds", arguments: Array(stride(from: 0, to: 60, by: 2)))
    func secondsLampIsOnForEvenSeconds(seconds: UInt) {
        let original = engine.isSecondsLampOn(seconds: seconds).isEven
        #expect(original == true, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp is off for odd seconds", arguments: Array(stride(from: 1, to: 60, by: 2)))
    func secondsLampIsOffForEvenSeconds(seconds: UInt) {
        let original = engine.isSecondsLampOn(seconds: seconds).isEven
        #expect(original == false, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp should not be more than 59")
    func secondsLampShouldNotBeMoreThan59() {
        let seconds: UInt = 61
        let (isEven, error) = engine.isSecondsLampOn(seconds: seconds)
        #expect(isEven == nil)
        #expect(error  == "Invalid seconds: \(seconds). Seconds should not be more than 59.")
    }
}
