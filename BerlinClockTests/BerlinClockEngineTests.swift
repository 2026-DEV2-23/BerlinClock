import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds", arguments: Array(stride(from: 0, to: 60, by: 2)))
    func secondsLampIsOnForEvenSeconds(seconds: UInt) {
        let original = try! engine.secondsToLamp(seconds: seconds)
        #expect(original == .red, "Failed at seconds \(seconds)")
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
        ([5, 6, 7, 8, 9],      [LampState.red, LampState.off, LampState.off, LampState.off]),
        ([10, 11, 12, 13, 14], [LampState.red, LampState.red, LampState.off, LampState.off]),
        ([15, 16, 17, 18, 19], [LampState.red, LampState.red, LampState.red, LampState.off]),
        ([20, 21, 22, 23],     [LampState.red, LampState.red, LampState.red, LampState.red ])
    ])
    func fiveHourLampRows(hoursArray: [UInt], expected: [LampState]) {
        hoursArray.forEach {
            let original = try! engine.fiveHoursToLamp(hours: $0)
            #expect(original == expected, "Failed at hour \($0)")
        }
    }
    
    @Test("Throw an error when hours > 23", arguments: [24, 50, 60, 100, 130, 423, 654, 1000])
    func throwError_fiveHoursLamp_whenHours_greaterThan23(hours: UInt) {
        #expect {
            try engine.fiveHoursToLamp(hours: hours)
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidHours(hours) &&
            timeValidationError.localizedDescription == "Invalid hours: \(hours). Hours must be between 0 and 23."
        }
    }

    @Test("one hour row lamp test", arguments:[
        ([0, 5, 10, 15, 20],  [LampState.off, LampState.off, LampState.off, LampState.off]),
        ([1, 6, 11, 16, 21],  [LampState.red, LampState.off, LampState.off, LampState.off]),
        ([2, 7, 12, 17, 22],  [LampState.red, LampState.red, LampState.off, LampState.off]),
        ([3, 8, 13, 18, 23],  [LampState.red, LampState.red, LampState.red, LampState.off]),
        ([4, 9, 14, 19],      [LampState.red, LampState.red, LampState.red, LampState.red ])
    ])
    func oneHourLampRows(hoursArray: [UInt], expected: [LampState]) {
        hoursArray.forEach {
            let original = try! engine.oneHourToLamp(hours: $0)
            #expect(original == expected, "Failed at hour \($0)")
        }
    }
    
    @Test("Throw an error when hours > 23", arguments: [24, 50, 60, 100, 130, 423, 654, 1000])
    func throwError_oneHourLamp_whenHours_greaterThan23(hours: UInt) {
        #expect {
            try engine.oneHourToLamp(hours: hours)
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidHours(hours) &&
            timeValidationError.localizedDescription == "Invalid hours: \(hours). Hours must be between 0 and 23."
        }
    }
    
    @Test("five minutes lamp test when minutes = 5, 6, 7, 8, 9", arguments: [5, 6, 7, 8, 9])
    func fiveMinutesLamp_whenMinutes_IsEqual_5(minutes: UInt) {
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }

    @Test("five minutes lamp test when minutes = 10, 11, 12, 13, 14", arguments: [10, 11, 12, 13, 14])
    func fiveMinutesLamp_whenMinutes_IsEqual_10(minutes: UInt) {
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .off, .off, .off, .off, .off, .off, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 15, 16, 17, 18, 19", arguments: [15, 16, 17, 18, 19])
    func fiveMinutesLamp_whenMinutes_IsEqual_15_16_17_18_19(minutes: UInt) {
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .off, .off, .off, .off, .off, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 20, 21, 22, 23, 24", arguments: [20, 21, 22, 23, 24])
    func fiveMinutesLamp_whenMinutes_IsEqual_20_21_22_23_24(minutes: UInt) {
        let minutes: UInt = 20
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .yellow, .off, .off, .off, .off, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 25, 26, 27, 28, 29", arguments: [25, 26, 27, 28, 29])
    func fiveMinutesLamp_whenMinutes_IsEqual_25_26_27_28_29(minutes: UInt) {
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .off, .off, .off, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 30")
    func fiveMinutesLamp_whenMinutes_IsEqual_30() {
        let minutes: UInt = 30
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .off, .off, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 35")
    func fiveMinutesLamp_whenMinutes_IsEqual_35() {
        let minutes: UInt = 35
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 40")
    func fiveMinutesLamp_whenMinutes_IsEqual_40() {
        let minutes: UInt = 40
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 45")
    func fiveMinutesLamp_whenMinutes_IsEqual_45() {
        let minutes: UInt = 45
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 50")
    func fiveMinutesLamp_whenMinutes_IsEqual_50() {
        let minutes: UInt = 50
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 55")
    func fiveMinutesLamp_whenMinutes_IsEqual_55() {
        let minutes: UInt = 55
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }
    
    @Test("five minutes lamp test when minutes = 0")
    func fiveMinutesLamp_whenMinutes_IsEqual_0() {
        let minutes: UInt = 0
        let original = engine.fiveMinutesToLamp(minutes: minutes)
        let expected: [LampState] = [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off]
        #expect(original == expected, "Failed at minutes \(minutes)")
    }

}
