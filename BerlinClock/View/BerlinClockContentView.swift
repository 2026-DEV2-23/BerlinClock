import SwiftUI

struct BerlinClockContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .stroke(Color.gray, lineWidth: 5)
                .background {
                    Circle()
                        .fill(.red)
                }
                .frame(width: 80)
            
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
        .padding()
    }
}

#Preview {
    BerlinClockContentView()
}
