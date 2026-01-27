import Testing
@testable import BerlinClock

@Suite("Berlin Clock Engine Tests")
struct BerlinClockEngineTests {
    let engine = BerlinClockEngine()
    
    @Test("Seconds lamp is on for even seconds", arguments: Array(stride(from: 0, to: 60, by: 2)))
    func secondsLampIsOnForEvenSeconds(seconds: UInt) {
        secondsLamp(seconds: seconds, expected: .red)
    }
    
    @Test("Seconds lamp is off for odd seconds", arguments: Array(stride(from: 1, to: 60, by: 2)))
    func secondsLampIsOffForEvenSeconds(seconds: UInt) {
        secondsLamp(seconds: seconds, expected: .off)
    }
    
    private func secondsLamp(seconds: UInt, expected: LampState) {
        let time = getTime(seconds: seconds)
        let original = engine.convertDigitalTimeToLamp(time: time).secondsLamp
        #expect(original == expected, "Failed at seconds \(seconds)")
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
            let time = getTime(hours: $0)
            let original = engine.convertDigitalTimeToLamp(time: time).fiveHoursLamp
            #expect(original == expected, "Failed at hour \($0)")
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
            let time = getTime(hours: $0)
            let original = engine.convertDigitalTimeToLamp(time: time).oneHourLamp
            #expect(original == expected, "Failed at hour \($0)")
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
            let time = getTime(minutes: $0)
            let result = engine.convertDigitalTimeToLamp(time: time).fiveMinutesLamp
            #expect(result == expected, "Failed at minute \($0)")
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
            let time = getTime(minutes: $0)
            let result = engine.convertDigitalTimeToLamp(time: time).oneMinuteLamp
            #expect(result == expected, "Failed at minute \($0)")
        }
    }
    
    private func getTime(hours: UInt = 0, minutes: UInt = 0, seconds: UInt = 0) -> DigitalTime {
        return try! .init(hours: hours, minutes: minutes, seconds: seconds)
    }
}
