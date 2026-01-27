import SwiftUI

@main
struct BerlinClockApp: App {
    var body: some Scene {
        WindowGroup {
            let timeProvider = BerlinClockTimeProvider()
            let engine = BerlinClockEngine()
            let viewModel = BerlinClockViewModel(timeProviderProtocol: timeProvider, engineProtocol: engine)
            BerlinClockContentView(viewModel: viewModel)
        }
    }
}
