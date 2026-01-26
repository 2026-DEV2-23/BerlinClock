import Testing
@testable import BerlinClock

@Suite("Berlin Clock View Model Tests")
struct BerlinClockViewModelTests {

    let mockEngine = MockBerlinClockEngine()
    
    @Test("Default initial time")
    func defaultInitialTime() {
        let mockTime = try! DigitalTime(hours: 0, minutes: 0, seconds: 0)
        let mockTimeProvider = MockDigitalTimeProvider(digitalTime: mockTime)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp()
        
        #expect(viewModel.berlinClockLamp.secondsLamp == .off, "Failed in secondsLamp")
        #expect(viewModel.berlinClockLamp.fiveHoursLamp.allSatisfy { $0 == .off }, "Failed in fiveHoursLamp")
        #expect(viewModel.berlinClockLamp.fiveHoursLamp.count == 4, "Failed in fiveHoursLamp count")
        #expect(viewModel.berlinClockLamp.oneHourLamp.allSatisfy { $0 == .off }, "Failed in oneHourLamp")
        #expect(viewModel.berlinClockLamp.oneHourLamp.count == 4, "Failed in oneHourLamp count")
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp.allSatisfy { $0 == .off }, "Failed in fiveMinutesLamp")
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp.count == 11, "Failed in fiveMinutesLamp count")
        #expect(viewModel.berlinClockLamp.oneMinuteLamp.allSatisfy { $0 == .off }, "Failed in oneMinuteLamp")
        #expect(viewModel.berlinClockLamp.oneMinuteLamp.count == 4, "Failed in oneMinuteLamp count")
    }
    
    @Test("morning time test")
    func morningTime() {
        let mockTime = try! DigitalTime(hours: 8, minutes: 23, seconds: 2)
        let mockTimeProvider = MockDigitalTimeProvider(digitalTime: mockTime)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp()
        
        #expect(viewModel.berlinClockLamp.secondsLamp == .red)
        #expect(viewModel.berlinClockLamp.fiveHoursLamp == [.red, .off, .off, .off])
        #expect(viewModel.berlinClockLamp.oneHourLamp == [.red, .red, .red, .off])
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp == [.yellow, .yellow, .red, .yellow, .off, .off, .off, .off, .off, .off, .off])
        #expect(viewModel.berlinClockLamp.oneMinuteLamp == [.yellow, .yellow, .yellow, .off])
    }
    
    @Test("afternoon time test")
    func afternoonTime() {
        let mockTime = try! DigitalTime(hours: 15, minutes: 37, seconds: 55)
        let mockTimeProvider = MockDigitalTimeProvider(digitalTime: mockTime)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp()
        
        #expect(viewModel.berlinClockLamp.secondsLamp == .off)
        #expect(viewModel.berlinClockLamp.fiveHoursLamp == [.red, .red, .red, .off])
        #expect(viewModel.berlinClockLamp.oneHourLamp == [.off, .off, .off, .off])
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp == [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off, .off, .off, .off])
        #expect(viewModel.berlinClockLamp.oneMinuteLamp == [.yellow, .yellow, .off, .off])
    }
    
    @Test("evening time test")
    func eveningTime() {
        let mockTime = try! DigitalTime(hours: 19, minutes: 44, seconds: 45)
        let mockTimeProvider = MockDigitalTimeProvider(digitalTime: mockTime)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp()
        
        #expect(viewModel.berlinClockLamp.secondsLamp == .off)
        #expect(viewModel.berlinClockLamp.fiveHoursLamp == [.red, .red, .red, .off])
        #expect(viewModel.berlinClockLamp.oneHourLamp == [.red, .red, .red, .red])
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp == [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .off, .off, .off])
        #expect(viewModel.berlinClockLamp.oneMinuteLamp == [.yellow, .yellow, .yellow, .yellow])
    }
}
