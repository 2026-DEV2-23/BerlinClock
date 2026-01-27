import SwiftUI

struct BerlinClockContentView: View {
    
    private let strokeColor: Color = .gray
    private let strokeWidth: CGFloat = 5
    private let cornerRadiusRectangle: CGFloat = 5
    private let hStackRectangleSpacing: CGFloat = 15
    private let heightOfRectangle: CGFloat = 100
    private let heightOfCircle: CGFloat = 80
    
    var body: some View {
        VStack(spacing: 20) {
            secondsLampView
            fiveHoursLamp
            oneHourLamp
            fiveMinsLamp
            oneMinuteLamp
        }
        .padding()
    }
    
    private var secondsLampView: some View {
        Circle()
            .stroke(strokeColor, lineWidth: strokeWidth)
            .background {
                Circle()
                    .fill(.red)
            }
            .frame(width: heightOfCircle)
    }
    
    private var fiveHoursLamp: some View {
        HStack(spacing: hStackRectangleSpacing) {
            ForEach(0..<4, id:\.self) { index in
                RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                    .stroke(strokeColor, lineWidth: strokeWidth)
                    .background {
                        RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                            .fill(.red)
                    }
                    .frame(height: heightOfRectangle)
                
            }
        }
    }
    
    private var oneHourLamp: some View {
        HStack(spacing: hStackRectangleSpacing) {
            ForEach(0..<4, id:\.self) { index in
                RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                    .stroke(strokeColor, lineWidth: strokeWidth)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                            .fill(.red)
                    )
                    .frame(height: heightOfRectangle)
                
            }
        }
    }
    
    private var fiveMinsLamp: some View {
        HStack(spacing: hStackRectangleSpacing) {
            ForEach(0..<11, id:\.self) { index in
                RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                    .stroke(strokeColor, lineWidth: strokeWidth)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                            .fill(.red)
                    )
                    .frame(height: heightOfRectangle)
                
            }
        }
    }
    
    private var oneMinuteLamp: some View {
        HStack(spacing: hStackRectangleSpacing) {
            ForEach(0..<4, id:\.self) { index in
                RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                    .stroke(strokeColor, lineWidth: strokeWidth)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadiusRectangle)
                            .fill(.red)
                    )
                    .frame(height: heightOfRectangle)
                
            }
        }
    }
}

#Preview {
    BerlinClockContentView()
}
