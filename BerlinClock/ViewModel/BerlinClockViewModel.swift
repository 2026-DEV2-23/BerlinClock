import SwiftUI

@Observable
class BerlinClockViewModel {
    private(set) var berlinClockLamp: BerlinClockLamp = BerlinClockLamp.empty
    private let timeProviderProtocol: DigitalTimeProviderProtocol
    private let engineProtocol: BerlinClockEngineProtocol
    
    init(timeProviderProtocol: DigitalTimeProviderProtocol, engineProtocol: BerlinClockEngineProtocol) {
        self.timeProviderProtocol = timeProviderProtocol
        self.engineProtocol = engineProtocol
    }
    
    func updateBerlinClockLamp() {
        do {
            let time = try timeProviderProtocol.getDigitalTime()
            berlinClockLamp = engineProtocol.convertDigitalTimeToLamp(time: time)
        } catch {
            // handle the error later
            print(error.localizedDescription)
        }
    }
}
