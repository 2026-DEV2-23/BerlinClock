import SwiftUI

struct BerlinClockContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .stroke(Color.gray, lineWidth: 5)
                .background {
                    Circle()
                        .fill(.red)
                }
                .frame(width: 80)
        }
        .padding()
    }
}

#Preview {
    BerlinClockContentView()
}
