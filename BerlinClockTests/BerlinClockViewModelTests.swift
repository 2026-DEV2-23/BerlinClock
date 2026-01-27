import Testing
import Foundation
@testable import BerlinClock

@Suite("Berlin Clock View Model Tests")
struct BerlinClockViewModelTests {

    @Test("Default initial time")
    func defaultInitialTime() {
        let mockData = getMockData(hours: 0, minutes: 0, seconds: 0)
        
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let mockEngine = MockBerlinClockEngine(stubbedData: emptyBerlinClockLamp)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)
        
        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(mockEngine.convertDigitalTimeToLampCalled == true, "Failed at convertDigitalTimeToLampCalled")
        #expect(mockEngine.lastTime == mockData.time, "Failed at lastTime")
        
        #expect(viewModel.error == nil)
        #expect(viewModel.berlinClockLamp == emptyBerlinClockLamp, "Failed in emptyBerlinClockLamp")
    }
    
    @Test("morning time test")
    func morningTime() {
        let mockData = getMockData(hours: 8, minutes: 23, seconds: 2)
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let mockEngine = MockBerlinClockEngine(stubbedData: morningBerlinClockLamp)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)
        
        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(mockEngine.convertDigitalTimeToLampCalled == true, "Failed at convertDigitalTimeToLampCalled")
        #expect(mockEngine.lastTime == mockData.time, "Failed at lastTime")
        
        #expect(viewModel.error == nil, "Failed at error")
        #expect(viewModel.berlinClockLamp == morningBerlinClockLamp, "Failed in morningBerlinClockLamp")
    }
    
    @Test("afternoon time test")
    func afternoonTime() {
        let mockData = getMockData(hours: 15, minutes: 37, seconds: 55)
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let mockEngine = MockBerlinClockEngine(stubbedData: afternoonBerlinClockLamp)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)

        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(mockEngine.convertDigitalTimeToLampCalled == true, "Failed at convertDigitalTimeToLampCalled")
        #expect(mockEngine.lastTime == mockData.time, "Failed at lastTime")
        
        #expect(viewModel.error == nil, "Failed at error")
        #expect(viewModel.berlinClockLamp == afternoonBerlinClockLamp, "Failed in afternoonBerlinClockLamp")
    }
    
    @Test("evening time test")
    func eveningTime() {
        let mockData = getMockData(hours: 19, minutes: 44, seconds: 45)
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let mockEngine = MockBerlinClockEngine(stubbedData: eveningBerlinClockLamp)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)

        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(mockEngine.convertDigitalTimeToLampCalled == true, "Failed at convertDigitalTimeToLampCalled")
        #expect(mockEngine.lastTime == mockData.time, "Failed at lastTime")
        
        #expect(viewModel.berlinClockLamp == eveningBerlinClockLamp, "Failed in eveningBerlinClockLamp")
    }
    
    @Test("end of day test")
    func endOfDay() {
        let mockData = getMockData(hours: 23, minutes: 59, seconds: 59)
        let mockTimeProvider = MockDigitalTimeProvider(stubbedData: mockData.time)
        let mockEngine = MockBerlinClockEngine(stubbedData: endOfDayBerlinClockLamp)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        viewModel.updateBerlinClockLamp(date: mockData.date)

        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == mockData.date, "Failed at passedDate")
        
        #expect(mockEngine.convertDigitalTimeToLampCalled == true, "Failed at convertDigitalTimeToLampCalled")
        #expect(mockEngine.lastTime == mockData.time, "Failed at lastTime")
        
        #expect(viewModel.error == nil, "Failed at error")
        #expect(viewModel.berlinClockLamp == endOfDayBerlinClockLamp, "Failed in endOfDayBerlinClockLamp")
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
        let dummyDate = Date.now
        let mockTimeProvider = MockFailDigitalTimeProvider(errorToThrow: .invalidHours(61))
        let mockEngine = MockBerlinClockEngine(stubbedData: emptyBerlinClockLamp)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        // passing Date.now object as dummyDate, anyways below method will throw an error
        viewModel.updateBerlinClockLamp(date: dummyDate)
        
        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == dummyDate, "Failed at passedDate")
        
        #expect(mockEngine.convertDigitalTimeToLampCalled == false, "Failed at convertDigitalTimeToLampCalled")
        #expect(mockEngine.lastTime == nil, "Failed at lastTime")
        
        #expect(viewModel.error != nil, "Failed at error")
        #expect(viewModel.error as? TimeValidationError == .invalidHours(61), "Failed at invalidHours")
    }
    
    @Test("throw an invalidMinutes error when viewmodel updateBerlinClockLamp is called")
    func throwError_invalidMinutes_when_viewmodel_updateBerlinClockLamp_isCalled() {
        let dummyDate = Date.now
        let mockTimeProvider = MockFailDigitalTimeProvider(errorToThrow: .invalidMinutes(100))
        let mockEngine = MockBerlinClockEngine(stubbedData: emptyBerlinClockLamp)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        // passing Date.now object as dummyDate, anyways below method will throw an error
        viewModel.updateBerlinClockLamp(date: dummyDate)
        
        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == dummyDate, "Failed at passedDate")
        
        #expect(mockEngine.convertDigitalTimeToLampCalled == false, "Failed at convertDigitalTimeToLampCalled")
        #expect(mockEngine.lastTime == nil, "Failed at lastTime")
        
        #expect(viewModel.error != nil, "Failed at error")
        #expect(viewModel.error as? TimeValidationError == .invalidMinutes(100), "Failed at invalidMinutes")
    }
    
    @Test("throw an invalidSeconds error when viewmodel updateBerlinClockLamp is called")
    func throwError_invalidSeconds_when_viewmodel_updateBerlinClockLamp_isCalled() {
        let dummyDate = Date.now
        let mockTimeProvider = MockFailDigitalTimeProvider(errorToThrow: .invalidSeconds(222))
        let mockEngine = MockBerlinClockEngine(stubbedData: emptyBerlinClockLamp)
        let viewModel = BerlinClockViewModel(timeProviderProtocol: mockTimeProvider, engineProtocol: mockEngine)
        
        // passing Date.now object as dummyDate, anyways below method will throw an error
        viewModel.updateBerlinClockLamp(date: dummyDate)
        
        #expect(mockTimeProvider.getDigitalTimeCalled == true, "Failed at getDigitalTimeCalled")
        #expect(mockTimeProvider.passedDate == dummyDate, "Failed at passedDate")
        
        #expect(mockEngine.convertDigitalTimeToLampCalled == false, "Failed at convertDigitalTimeToLampCalled")
        #expect(mockEngine.lastTime == nil, "Failed at lastTime")
        
        #expect(viewModel.error != nil, "Failed at error")
        #expect(viewModel.error as? TimeValidationError == .invalidSeconds(222), "Failed at invalidSeconds")
    }

    private func getTime(hours: UInt, minutes: UInt, seconds: UInt) -> DigitalTime {
        return try! .init(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    private let emptyBerlinClockLamp: BerlinClockLamp = BerlinClockLamp.empty
    
    private let morningBerlinClockLamp: BerlinClockLamp =
        BerlinClockLamp(
            secondsLamp: .red,
            fiveHoursLamp: [.red, .off, .off, .off],
            oneHourLamp: [.red, .red, .red, .off],
            fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .off, .off, .off, .off, .off, .off, .off],
            oneMinuteLamp: [.yellow, .yellow, .yellow, .off]
        )

    private let afternoonBerlinClockLamp: BerlinClockLamp =
        BerlinClockLamp(
            secondsLamp: .off,
            fiveHoursLamp: [.red, .red, .red, .off],
            oneHourLamp: [.off, .off, .off, .off],
            fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off, .off, .off, .off],
            oneMinuteLamp: [.yellow, .yellow, .off, .off]
        )
    
    private let eveningBerlinClockLamp: BerlinClockLamp =
        BerlinClockLamp(
            secondsLamp: .off,
            fiveHoursLamp: [.red, .red, .red, .off],
            oneHourLamp: [.red, .red, .red, .red],
            fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .off, .off, .off],
            oneMinuteLamp: [.yellow, .yellow, .yellow, .yellow]
        )
    
    private let endOfDayBerlinClockLamp: BerlinClockLamp =
        BerlinClockLamp(
            secondsLamp: .off,
            fiveHoursLamp: [.red, .red, .red, .red],
            oneHourLamp: [.red, .red, .red, .off],
            fiveMinutesLamp: [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow],
            oneMinuteLamp: [.yellow, .yellow, .yellow, .yellow]
        )
}
