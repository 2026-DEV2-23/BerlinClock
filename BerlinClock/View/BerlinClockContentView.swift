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
            lampView(lamps: 4)
            lampView(lamps: 4)
            lampView(lamps: 11)
            lampView(lamps: 4)
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
    
    private func lampView(lamps: Int) -> some View {
        HStack(spacing: hStackRectangleSpacing) {
            ForEach(0..<lamps, id:\.self) { index in
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
}

#Preview {
    BerlinClockContentView()
}
