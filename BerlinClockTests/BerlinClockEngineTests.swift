import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds", arguments: Array(stride(from: 0, to: 60, by: 2)))
    func secondsLampIsOnForEvenSeconds(seconds: UInt) {
        let original = try! engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: 0, minutes: 0, seconds: seconds)).secondsLamp
        #expect(original == .red, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp is off for odd seconds", arguments: Array(stride(from: 1, to: 60, by: 2)))
    func secondsLampIsOffForEvenSeconds(seconds: UInt) {
        let original = try! engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: 0, minutes: 0, seconds: seconds)).secondsLamp
        #expect(original == .off, "Failed at seconds \(seconds)")
    }
    
    @Test("Seconds lamp should not be more than 59", arguments: [61, 72, 75, 100, 200, 333, 555, 1000])
    func throwError_whenSeconds_greaterThan59(seconds: UInt) {
        #expect {
            try engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: 0, minutes: 0, seconds: seconds)).secondsLamp
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
            let original = try! engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: $0, minutes: 0, seconds: 0)).fiveHoursLamp
            #expect(original == expected, "Failed at hour \($0)")
        }
    }
    
    @Test("Throw an error when hours > 23", arguments: [24, 50, 60, 100, 130, 423, 654, 1000])
    func throwError_fiveHoursLamp_whenHours_greaterThan23(hours: UInt) {
        #expect {
            try engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: hours, minutes: 0, seconds: 0)).fiveHoursLamp
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
            let original = try! engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: $0, minutes: 0, seconds: 0)).oneHourLamp
            #expect(original == expected, "Failed at hour \($0)")
        }
    }
    
    @Test("Throw an error when hours > 23", arguments: [24, 50, 60, 100, 130, 423, 654, 1000])
    func throwError_oneHourLamp_whenHours_greaterThan23(hours: UInt) {
        #expect {
            try engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: hours, minutes: 0, seconds: 0)).oneHourLamp
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidHours(hours) &&
            timeValidationError.localizedDescription == "Invalid hours: \(hours). Hours must be between 0 and 23."
        }
    }
    
    
    @Test("five mins lamp test", arguments: [
        ([0, 1, 2, 3, 4],
         [LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off]),
        
        ([5, 6, 7, 8, 9],
         [LampState.yellow, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off]),
        
        ([10, 11, 12, 13, 14],
         [LampState.yellow, LampState.yellow, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off]),
        
        ([15, 16, 17, 18, 19],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off]),
        
        ([20, 21, 22, 23, 24],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off]),
        
        ([25, 26, 27, 28, 29],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off]),
        
        ([30, 31, 32, 33, 34],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off]),
        
        ([35, 36, 37, 38, 39],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.off, LampState.off, LampState.off, LampState.off]),
        
        ([40, 41, 42, 43, 44],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.off, LampState.off, LampState.off]),
        
        ([45, 46, 47, 48, 49],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.off, LampState.off]),
        
        ([50, 51, 52, 53, 54],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.off]),
        
        ([55, 56, 57, 58, 59],
         [LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow])
    ])
    
    func fiveMinsLampRows(minutesArray: [UInt], expected: [LampState]) {
        minutesArray.forEach {
            let result = try! engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: 0, minutes: $0, seconds: 0)).fiveMinutesLamp
            #expect(result == expected, "Failed at minute \($0)")
        }
    }
    
    @Test("Throw an error when minutes > 59", arguments: [60, 69, 99, 150, 201, 678, 904, 1000])
    func throwError_fiveMinutesLamp_whenMinutes_greaterThan59(minutes: UInt) {
        #expect {
            _ = try engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: 0, minutes: minutes, seconds: 0)).fiveMinutesLamp
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidMinutes(minutes) &&
            timeValidationError.localizedDescription == "Invalid minutes: \(minutes). Minutes must be between 0 and 59."
        }
    }
    
    @Test("one minute lamp test", arguments: [
        ([0],                                            [LampState.off,    LampState.off,    LampState.off,    LampState.off]),
        ([1, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56], [LampState.yellow, LampState.off,    LampState.off,    LampState.off]),
        ([2, 7, 12, 17, 22, 27, 32, 37, 42, 47, 52, 57], [LampState.yellow, LampState.yellow, LampState.off,    LampState.off]),
        ([3, 8, 13, 18, 23, 28, 33, 38, 43, 48, 53, 58], [LampState.yellow, LampState.yellow, LampState.yellow, LampState.off]),
        ([4, 9, 14, 19, 24, 29, 34, 39, 44, 49, 54, 59], [LampState.yellow, LampState.yellow, LampState.yellow, LampState.yellow])
    ])
    func oneMinuteLampRows(minArray: [UInt], expected: [LampState]) {
        minArray.forEach {
            let result = try! engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: 0, minutes: $0, seconds: 0)).oneMinuteLamp
            #expect(result == expected, "Failed at minute \($0)")
        }
    }
    
    @Test("Throw an error when minutes > 59", arguments: [60, 69, 99, 150, 201, 678, 904, 1000])
    func throwError_oneMinuteLamp_whenMinutes_greaterThan59(minutes: UInt) {
        #expect {
            _ = try engine.convertHoursMinutesAndSecondsToLamp(time: .init(hours: 0, minutes: minutes, seconds: 0)).oneMinuteLamp
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidMinutes(minutes) &&
            timeValidationError.localizedDescription == "Invalid minutes: \(minutes). Minutes must be between 0 and 59."
        }
    }
    
}
