import SwiftUI

@Observable
class BerlinClockViewModel {
    private(set) var berlinClockLamp: BerlinClockLamp = BerlinClockLamp.empty
    private let timeProviderProtocol: DigitalTimeProviderProtocol
    private let engineProtocol: BerlinClockEngineProtocol
    private(set) var error: Error?
    
    init(timeProviderProtocol: DigitalTimeProviderProtocol, engineProtocol: BerlinClockEngineProtocol) {
        self.timeProviderProtocol = timeProviderProtocol
        self.engineProtocol = engineProtocol
    }
    
    func updateBerlinClockLamp() {
        do {
            let time = try timeProviderProtocol.getDigitalTime()
            berlinClockLamp = engineProtocol.convertDigitalTimeToLamp(time: time)
            error = nil
        } catch {
            self.error = error
        }
    }
}
