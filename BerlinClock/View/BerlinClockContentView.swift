import SwiftUI

struct BerlinClockContentView: View {
    
    private let strokeColor: Color = Color(.systemGray)
    private let strokeWidth: CGFloat = 5
    private let cornerRadiusRectangle: CGFloat = 5
    private let hStackRectangleSpacing: CGFloat = 15
    private let heightOfRectangle: CGFloat = 100
    private let widthOfCircle: CGFloat = 80
    
    let viewModel: BerlinClockViewModel
    
    // Tracks the pause state
    @State private var isTimeLineViewPaused = false
    
    @State private var timeString = ""
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    var body: some View {
        Group {
            if let error = viewModel.error {
                errorView(error: error)
            } else {
                clockStack
            }
        }
        .background {
            timeLineView
        }
        .padding(20)
    }
    
    private func errorView(error: Error) -> some View {
        ContentUnavailableView {
            Label("Clock Error", systemImage: "exclamationmark.triangle.fill")
        } description: {
            let errorMessage = (error as? TimeValidationError)?.localizedDescription
            ?? error.localizedDescription
            Text(errorMessage)
                .font(.subheadline)
        }
        .foregroundStyle(Color(.systemRed))
        .onAppear {
            isTimeLineViewPaused = true
        }
    }
     
    private var timeLineView: some View {
        TimelineView(.animation(minimumInterval: 1.0, paused: isTimeLineViewPaused)) { context in
            Color.clear
                .onChange(of: context.date) { _, newDate in
                    viewModel.updateBerlinClockLamp(date: newDate)
                    timeString = Self.dateFormatter.string(from: newDate)
                }
        }
    }
    
    private var clockStack: some View {
        VStack(spacing: 20) {
            secondsLampView
            lampView(lamps: viewModel.berlinClockLamp.fiveHoursLamp)
            lampView(lamps: viewModel.berlinClockLamp.oneHourLamp)
            lampView(lamps: viewModel.berlinClockLamp.fiveMinutesLamp)
            lampView(lamps: viewModel.berlinClockLamp.oneMinuteLamp)
            displayTime
        }
    }
    
    private var displayTime: some View {
        Text(timeString)
            .font(.system(.largeTitle, design: .monospaced))
            .foregroundStyle(.primary)
            .bold()
    }
    
    private var secondsLampView: some View {
        Circle()
            .stroke(strokeColor, lineWidth: strokeWidth)
            .background {
                Circle()
                    .fill(viewModel.berlinClockLamp.secondsLamp == .red ? .red : .clear)
            }
            .frame(width: widthOfCircle)
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
        case .red: Color(.systemRed)
        case .yellow: Color(.systemYellow)
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
