import Testing
import Foundation
@testable import BerlinClock

@Suite("Berlin Clock View Model Tests")
struct BerlinClockViewModelTests {

    let mockEngine = MockBerlinClockEngine()
    
    @Test("Default initial time")
    func defaultInitialTime() {
        let mockData = getMockData(hours: 0, minutes: 0, seconds: 0)
        
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)
        
        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(viewModel.error == nil)
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
        let mockData = getMockData(hours: 8, minutes: 23, seconds: 2)
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)
        
        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(viewModel.error == nil, "Failed at error")
        #expect(viewModel.berlinClockLamp.secondsLamp == .red, "Failed at secondsLamp")
        #expect(viewModel.berlinClockLamp.fiveHoursLamp == [.red, .off, .off, .off], "Failed at fiveHoursLamp")
        #expect(viewModel.berlinClockLamp.oneHourLamp == [.red, .red, .red, .off], "Failed at oneHourLamp")
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp == [.yellow, .yellow, .red, .yellow, .off, .off, .off, .off, .off, .off, .off], "Failed at fiveMinutesLamp")
        #expect(viewModel.berlinClockLamp.oneMinuteLamp == [.yellow, .yellow, .yellow, .off], "Failed at oneMinuteLamp")
    }
    
    @Test("afternoon time test")
    func afternoonTime() {
        let mockData = getMockData(hours: 15, minutes: 37, seconds: 55)
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)

        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(viewModel.error == nil, "Failed at error")
        #expect(viewModel.berlinClockLamp.secondsLamp == .off, "Failed at secondsLamp")
        #expect(viewModel.berlinClockLamp.fiveHoursLamp == [.red, .red, .red, .off], "Failed at fiveHoursLamp")
        #expect(viewModel.berlinClockLamp.oneHourLamp == [.off, .off, .off, .off], "Failed at oneHourLamp")
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp == [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off, .off, .off, .off], "Failed at fiveMinutesLamp")
        #expect(viewModel.berlinClockLamp.oneMinuteLamp == [.yellow, .yellow, .off, .off], "Failed at oneMinuteLamp")
    }
    
    @Test("evening time test")
    func eveningTime() {
        let mockData = getMockData(hours: 19, minutes: 44, seconds: 45)
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)

        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(viewModel.error == nil, "Failed at error")
        #expect(viewModel.berlinClockLamp.secondsLamp == .off, "Failed at secondsLamp")
        #expect(viewModel.berlinClockLamp.fiveHoursLamp == [.red, .red, .red, .off], "Failed at fiveHoursLamp")
        #expect(viewModel.berlinClockLamp.oneHourLamp == [.red, .red, .red, .red], "Failed at oneHourLamp")
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp == [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .off, .off, .off], "Failed at fiveMinutesLamp")
        #expect(viewModel.berlinClockLamp.oneMinuteLamp == [.yellow, .yellow, .yellow, .yellow], "Failed at oneMinuteLamp")
    }
    
    @Test("end of day test")
    func endOfDay() {
        let mockData = getMockData(hours: 23, minutes: 59, seconds: 59)
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)

        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(viewModel.error == nil, "Failed at error")
        #expect(viewModel.berlinClockLamp.secondsLamp == .off, "Failed at secondsLamp")
        #expect(viewModel.berlinClockLamp.fiveHoursLamp == [.red, .red, .red, .red], "Failed at fiveHoursLamp")
        #expect(viewModel.berlinClockLamp.oneHourLamp == [.red, .red, .red, .off], "Failed at oneHourLamp")
        #expect(viewModel.berlinClockLamp.fiveMinutesLamp == [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow], "Failed at fiveMinutesLamp")
        #expect(viewModel.berlinClockLamp.oneMinuteLamp == [.yellow, .yellow, .yellow, .yellow], "Failed at oneMinuteLamp")
    }
    
    private func getMockData(hours: UInt, minutes: UInt, seconds: UInt) -> (date: Date, time: DigitalTime) {
        var dateComponent = DateComponents()
        dateComponent.hour = Int(hours)
        dateComponent.minute = Int(minutes)
        dateComponent.second = Int(seconds)
        
        let mockDate = Calendar.current.date(from: dateComponent)!
        let mockTime = getTime(hours: hours, minutes: minutes, seconds: seconds)
        return (mockDate, mockTime)
    }
    
    @Test("throw an invalidHours error when viewmodel updateBerlinClockLamp is called")
    func throwError_invalidHours__when_viewmodel_updateBerlinClockLamp_isCalled() {
        let mockTimeProvider = MockFailDigitalTimeProvider(errorToThrow: .invalidHours(61))
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        // passing Date.now object as dummyDate, anyways below method will throw an error
        viewModel.updateBerlinClockLamp(date: .now)
        
        #expect(viewModel.error != nil, "Failed at error")
        #expect(viewModel.error as? TimeValidationError == .invalidHours(61), "Failed at invalidHours")
    }
    
    @Test("throw an invalidMinutes error when viewmodel updateBerlinClockLamp is called")
    func throwError_invalidMinutes_when_viewmodel_updateBerlinClockLamp_isCalled() {
        let mockTimeProvider = MockFailDigitalTimeProvider(errorToThrow: .invalidMinutes(100))
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        // passing Date.now object as dummyDate, anyways below method will throw an error
        viewModel.updateBerlinClockLamp(date: .now)
        
        #expect(viewModel.error != nil, "Failed at error")
        #expect(viewModel.error as? TimeValidationError == .invalidMinutes(100), "Failed at invalidMinutes")
    }
    
    @Test("throw an invalidSeconds error when viewmodel updateBerlinClockLamp is called")
    func throwError_invalidSeconds_when_viewmodel_updateBerlinClockLamp_isCalled() {
        let mockTimeProvider = MockFailDigitalTimeProvider(errorToThrow: .invalidSeconds(222))
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        // passing Date.now object as dummyDate, anyways below method will throw an error
        viewModel.updateBerlinClockLamp(date: .now)
        
        #expect(viewModel.error != nil, "Failed at error")
        #expect(viewModel.error as? TimeValidationError == .invalidSeconds(222), "Failed at invalidSeconds")
    }

    private func getTime(hours: UInt, minutes: UInt, seconds: UInt) -> DigitalTime {
        return try! .init(hours: hours, minutes: minutes, seconds: seconds)
    }
}
