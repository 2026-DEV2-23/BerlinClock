enum LampState: Equatable {
    case off
    case red
    case yellow
    
    // Manually implementing the comparison to strip away actor isolation
    nonisolated static func == (lhs: LampState, rhs: LampState) -> Bool {
        switch (lhs, rhs) {
        case (.off, .off), (.red, .red), (.yellow, .yellow):
            return true
        default:
            return false
        }
    }
}
