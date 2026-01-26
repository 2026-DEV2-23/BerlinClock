import Testing
@testable import BerlinClock

@Suite("Berlin Clock View Model Tests")
struct BerlinClockViewModelTests {
    let viewModel = BerlinClockViewModel()
    
    @Test("test initial values of berlinClockLamp")
    func testInitialState() {
        #expect(viewModel.berlinClockLamp.secondsLamp == .off)
        #expect(viewModel.berlinClockLamp.fiveHoursLamp.allSatisfy { $0 == .off })
        #expect(viewModel.berlinClockLamp.fiveHoursLamp.count == 4)
        #expect(viewModel.berlinClockLamp.oneHourLamp.allSatisfy { $0 == .off })
        #expect(viewModel.berlinClockLamp.oneHourLamp.count == 4)
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp.allSatisfy { $0 == .off })
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp.count == 11)
        #expect(viewModel.berlinClockLamp.oneMinuteLamp.allSatisfy { $0 == .off })
        #expect(viewModel.berlinClockLamp.oneMinuteLamp.count == 4)
    }
    
}
