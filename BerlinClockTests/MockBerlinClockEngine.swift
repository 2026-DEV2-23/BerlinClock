import Testing
@testable import BerlinClock

class MockBerlinClockEngine: BerlinClockEngineProtocol {
    
    private let stubbedData: BerlinClockLamp
    private(set) var lastTime: DigitalTime?
    private(set) var convertDigitalTimeToLampCalled = false
    
    init(stubbedData: BerlinClockLamp) {
        self.stubbedData = stubbedData
    }
    
    func convertDigitalTimeToLamp(time: DigitalTime) -> BerlinClockLamp {
        convertDigitalTimeToLampCalled = true
        lastTime = time
        return stubbedData
    }
}
