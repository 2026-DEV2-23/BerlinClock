import Testing
import Foundation
@testable import BerlinClock

class MockDigitalTimeProvider: DigitalTimeProviderProtocol {
    private let stubbedData: DigitalTime
    private(set) var passedDate: Date?
    private(set) var getDigitalTimeCalled = false
    
    func getDigitalTime(from date: Date) throws -> DigitalTime {
        getDigitalTimeCalled = true
        passedDate = date
        return stubbedData
    }
    
    init(stubbedData: DigitalTime) {
        self.stubbedData = stubbedData
    }
}
