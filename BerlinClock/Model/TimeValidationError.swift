enum TimeValidationError: Error, Equatable {
    case invalidSeconds(UInt)
    case invalidHours(UInt)
    case invalidMinutes(UInt)
    
    var localizedDescription: String {
        switch self {
        case .invalidSeconds(let seconds):
            return "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
        case .invalidHours(let hours):
            return "Invalid hours: \(hours). Hours must be between 0 and 23."
        case .invalidMinutes(let minutes):
            return "Invalid minutes: \(minutes). Minutes must be between 0 and 59."
        }
    }
}
