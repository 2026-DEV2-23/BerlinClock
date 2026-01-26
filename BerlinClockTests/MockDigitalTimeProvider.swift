import Testing
@testable import BerlinClock

class MockDigitalTimeProvider: DigitalTimeProviderProtocol {
    private let digitalTime: DigitalTime
    
    init(digitalTime: DigitalTime) {
        self.digitalTime = digitalTime
    }
    
    func getDigitalTime() throws -> DigitalTime {
        self.digitalTime
    }
}

