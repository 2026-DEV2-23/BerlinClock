import Testing
import Foundation
@testable import BerlinClock

class MockFailDigitalTimeProvider: DigitalTimeProviderProtocol {
    func getDigitalTime(from date: Date) throws -> DigitalTime {
        throw errorToThrow
    }
    
    let errorToThrow: TimeValidationError

    init(errorToThrow: TimeValidationError) {
        self.errorToThrow = errorToThrow
    }
}

