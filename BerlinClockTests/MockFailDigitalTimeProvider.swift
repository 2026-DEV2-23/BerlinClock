import Testing
import Foundation
@testable import BerlinClock

class MockFailDigitalTimeProvider: DigitalTimeProviderProtocol {
    private(set) var passedDate: Date?
    private(set) var getDigitalTimeCalled = false
    
    func getDigitalTime(from date: Date) throws -> DigitalTime {
        getDigitalTimeCalled = true
        passedDate = date
        throw errorToThrow
    }
    
    let errorToThrow: TimeValidationError

    init(errorToThrow: TimeValidationError) {
        self.errorToThrow = errorToThrow
    }
}

