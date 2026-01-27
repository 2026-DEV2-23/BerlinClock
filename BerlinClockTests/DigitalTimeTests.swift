import Testing
@testable import BerlinClock

@Suite("Digital Time Tests")
struct DigitalTimeTests {

    @Test("Throw an error when seconds > 59", arguments: [61, 72, 75, 100, 200, 333, 555, 1000])
    func throwError_whenSeconds_greaterThan59(seconds: UInt) {
        #expect {
            _ = try DigitalTime.init(hours: 0, minutes: 0, seconds: seconds)
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidSeconds(seconds) &&
            timeValidationError.localizedDescription == "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
        }
    }
    
    @Test("Throw an error when hours > 23", arguments: [24, 50, 60, 100, 130, 423, 654, 1000])
    func throwError_whenHours_greaterThan23(hours: UInt) {
        #expect {
            _ = try DigitalTime.init(hours: hours, minutes: 0, seconds: 0)
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidHours(hours) &&
            timeValidationError.localizedDescription == "Invalid hours: \(hours). Hours must be between 0 and 23."
        }
    }
    
    @Test("Throw an error when minutes > 59", arguments: [60, 69, 99, 150, 201, 678, 904, 1000])
    func throwError_whenMinutes_greaterThan59(minutes: UInt) {
        #expect {
            _ = try DigitalTime.init(hours: 0, minutes: minutes, seconds: 0)
        } throws: { error in
            guard let timeValidationError = error as? TimeValidationError else { return false }
            
            return timeValidationError == .invalidMinutes(minutes) &&
            timeValidationError.localizedDescription == "Invalid minutes: \(minutes). Minutes must be between 0 and 59."
        }
    }
    
    @Test("valid seconds range tests", arguments: 0...59)
    func validSecondsRange(seconds: UInt) {
        let hours: UInt = 0
        let minutes: UInt = 0
        let time = try! DigitalTime(hours: hours, minutes: minutes, seconds: seconds)
                
        #expect(time.hours == hours)
        #expect(time.minutes == minutes)
        #expect(time.seconds == seconds)
    }
}
