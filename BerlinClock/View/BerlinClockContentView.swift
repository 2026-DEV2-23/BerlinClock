import SwiftUI

struct BerlinClockContentView: View {
    
    private let strokeColor: Color = .gray
    private let strokeWidth: CGFloat = 5
    private let cornerRadiusRectangle: CGFloat = 5
    private let hStackRectangleSpacing: CGFloat = 15
    private let heightOfRectangle: CGFloat = 100
    private let heightOfCircle: CGFloat = 80
    
    let viewModel: BerlinClockViewModel
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            VStack(spacing: 20) {
                secondsLampView
                lampView(lamps: viewModel.berlinClockLamp.fiveHoursLamp)
                lampView(lamps: viewModel.berlinClockLamp.oneHourLamp)
                lampView(lamps: viewModel.berlinClockLamp.fiveMinutesLamp)
                lampView(lamps: viewModel.berlinClockLamp.oneMinuteLamp)
            }
            .onChange(of: context.date) { _, newDate in
                viewModel.updateBerlinClockLamp(date: newDate)
            }
        }
        .padding()
    }
    
    private var secondsLampView: some View {
        Circle()
            .stroke(strokeColor, lineWidth: strokeWidth)
            .background {
                Circle()
                    .fill(viewModel.berlinClockLamp.secondsLamp == .red ? .red : .clear)
            }
            .frame(width: heightOfCircle)
    }
    
    private func lampView(lamps: [LampState]) -> some View {
        HStack(spacing: hStackRectangleSpacing) {
            ForEach(0..<lamps.count, id:\.self) { index in
                RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                    .stroke(strokeColor, lineWidth: strokeWidth)
                    .background {
                        RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                            .fill(lamps[index].color)
                    }
                    .frame(height: heightOfRectangle)
                
            }
        }
    }
}

private extension LampState {
    var color: Color {
        switch self {
        case .red: .red
        case .yellow: .yellow
        case .off: .clear
        }
    }
}

#Preview {
    let timeProvider = BerlinClockTimeProvider()
    let engine = BerlinClockEngine()
    let viewModel = BerlinClockViewModel(timeProviderProtocol: timeProvider, engineProtocol: engine)
    BerlinClockContentView(viewModel: viewModel)
}
