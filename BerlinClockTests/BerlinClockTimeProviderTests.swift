import Testing
import Foundation
@testable import BerlinClock

@Suite("Berlin Clock Time Provider Tests")
struct BerlinClockTimeProviderTests {
    
    let timerProvider = BerlinClockTimeProvider()
    
    @Test("handle morning time")
    func handleMorningTime() throws {
        let hours: UInt = 8
        let minutes: UInt = 23
        let seconds: UInt = 2
        let mockDate = getMockData(hours: hours, minutes: minutes, seconds: seconds)
        let original = try timerProvider.getDigitalTime(from: mockDate)
        
        #expect(original.hours == hours)
        #expect(original.minutes == minutes)
        #expect(original.seconds == seconds)
    }
    
    private func getMockData(hours: UInt, minutes: UInt, seconds: UInt) -> Date {
        var dateComponent = DateComponents()
        dateComponent.hour = Int(hours)
        dateComponent.minute = Int(minutes)
        dateComponent.second = Int(seconds)
        
        let mockDate = Calendar.current.date(from: dateComponent)!
        return mockDate
    }
}
