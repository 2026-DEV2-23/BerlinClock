import Testing
@testable import BerlinClock

class MockFailDigitalTimeProvider: DigitalTimeProviderProtocol {
    let errorToThrow: TimeValidationError

    init(errorToThrow: TimeValidationError) {
        self.errorToThrow = errorToThrow
    }

    func getDigitalTime() throws -> DigitalTime {
        throw errorToThrow
    }
}

