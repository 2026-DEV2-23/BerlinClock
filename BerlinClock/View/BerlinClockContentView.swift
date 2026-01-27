import SwiftUI

struct BerlinClockContentView: View {
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
            .stroke(Color.gray, lineWidth: 5)
            .background {
                Circle()
                    .fill(.red)
            }
            .frame(width: 80)
    }
    
    private var fiveHoursLamp: some View {
        HStack(spacing: 15) {
            ForEach(0..<4, id:\.self) { index in
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 5)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.red)
                    }
                    .frame(height: 100)
                
            }
        }
    }
    
    private var oneHourLamp: some View {
        HStack(spacing: 15) {
            ForEach(0..<4, id:\.self) { index in
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 5)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.red)
                    )
                    .frame(height: 100)
                
            }
        }
    }
    
    private var fiveMinsLamp: some View {
        HStack(spacing: 15) {
            ForEach(0..<11, id:\.self) { index in
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 5)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.red)
                    )
                    .frame(height: 100)
                
            }
        }
    }
    
    private var oneMinuteLamp: some View {
        HStack(spacing: 15) {
            ForEach(0..<4, id:\.self) { index in
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 5)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.red)
                    )
                    .frame(height: 100)
                
            }
        }
    }
}

#Preview {
    BerlinClockContentView()
}
