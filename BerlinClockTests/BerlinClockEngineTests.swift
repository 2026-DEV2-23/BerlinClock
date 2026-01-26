import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds", arguments: Array(stride(from: 0, to: 60, by: 2)))
    func secondsLampIsOnForEvenSeconds(seconds: UInt) {
        let original = try! engine.secondsLamps(seconds: seconds)
        #expect(original == .on, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp is off for odd seconds", arguments: Array(stride(from: 1, to: 60, by: 2)))
    func secondsLampIsOffForEvenSeconds(seconds: UInt) {
        let original = try! engine.secondsLamps(seconds: seconds)
        #expect(original == .off, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp should not be more than 59", arguments: [61, 72, 75, 100, 200, 333, 555, 1000])
    func secondsLampShouldNotBeMoreThan59(seconds: UInt) {
        #expect {
            try engine.secondsLamps(seconds: seconds)
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidSeconds(seconds) &&
            timeValidationError.localizedDescription == "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
        }
    }
    
    @Test("Five hours lamp test when hour = 5, 6, 7, 8, 9", arguments: [5, 6, 7, 8, 9])
    func fiveHoursLamp_whenHours_IsEqual_5_6_7_8_9(hours: UInt) {
        let original = engine.fiveHoursToLamp(hours: hours)
        let expected: [LampState] = [.on, .off, .off, .off]
        #expect(original == expected, "Failed at hours \(hours)")
    }
    
    @Test("Five hours lamp test when hour = 10, 11, 12, 13, 14", arguments: [10, 11, 12, 13, 14])
    func fiveHoursLamp_whenHours_IsEqual_10_11_12_13_14_15(hours: UInt) {
        let original = engine.fiveHoursToLamp(hours: hours)
        let expected: [LampState] = [.on, .on, .off, .off]
        #expect(original == expected, "Failed at hours \(hours)")
    }
    
    @Test("Five hours lamp test when hour = 15")
    func fiveHoursLamp_whenHours_IsEqual_15() {
        let hours: UInt = 15
        let original = engine.fiveHoursToLamp(hours: hours)
        let expected: [LampState] = [.on, .on, .on, .off]
        #expect(original == expected, "Failed at hours \(hours)")
    }
    
    @Test("Five hours lamp test when hour = 20")
    func fiveHoursLamp_whenHours_IsEqual_20() {
        let hours: UInt = 20
        let original = engine.fiveHoursToLamp(hours: hours)
        let expected: [LampState] = [.on, .on, .on, .on]
        #expect(original == expected, "Failed at hours \(hours)")
    }

}
