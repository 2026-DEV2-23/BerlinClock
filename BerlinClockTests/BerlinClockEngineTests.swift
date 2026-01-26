import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds", arguments: Array(stride(from: 0, to: 60, by: 2)))
    func secondsLampIsOnForEvenSeconds(seconds: UInt) {
        let original = try! engine.secondsToLamp(seconds: seconds)
        #expect(original == .on, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp is off for odd seconds", arguments: Array(stride(from: 1, to: 60, by: 2)))
    func secondsLampIsOffForEvenSeconds(seconds: UInt) {
        let original = try! engine.secondsToLamp(seconds: seconds)
        #expect(original == .off, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp should not be more than 59", arguments: [61, 72, 75, 100, 200, 333, 555, 1000])
    func throwError_whenSeconds_greaterThan59(seconds: UInt) {
        #expect {
            try engine.secondsToLamp(seconds: seconds)
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidSeconds(seconds) &&
            timeValidationError.localizedDescription == "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
        }
    }
    
    @Test("Five hours row lamp test", arguments: [
        ([0, 1, 2, 3, 4],      [LampState.off, LampState.off, LampState.off, LampState.off]),
        ([5, 6, 7, 8, 9],      [LampState.on,  LampState.off, LampState.off, LampState.off]),
        ([10, 11, 12, 13, 14], [LampState.on,  LampState.on,  LampState.off, LampState.off]),
        ([15, 16, 17, 18, 19], [LampState.on,  LampState.on,  LampState.on,  LampState.off]),
        ([20, 21, 22, 23],     [LampState.on,  LampState.on,  LampState.on,  LampState.on ])
    ])
    func fiveHourLampRows(hoursArray: [UInt], expected: [LampState]) {
        hoursArray.forEach {
            let original = try! engine.fiveHoursToLamp(hours: $0)
            #expect(original == expected, "Failed at hour \($0)")
        }
    }
    
    @Test("Throw an error when hours > 23", arguments: [24, 50, 60, 100, 130, 423, 654, 1000])
    func throwError_whenHours_greaterThan23(hours: UInt) {
        #expect {
            try engine.fiveHoursToLamp(hours: hours)
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidHours(hours) &&
            timeValidationError.localizedDescription == "Invalid hours: \(hours). Hours must be between 0 and 23."
        }
    }

    @Test("one hour lamp test when hour = 1")
    func oneHourLamp_whenHours_IsEqual_1() {
        let hours: UInt = 1
        let original = engine.oneHourToLamp(hours: hours)
        let expected: [LampState] = [.on, .off, .off, .off]
        #expect(original == expected, "Failed at hours \(hours)")
    }

}
