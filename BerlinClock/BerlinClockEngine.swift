class BerlinClockEngine {
    
    func isSecondsLampOn(seconds: UInt) throws -> Bool {
        if !(0...59).contains(seconds) {
            throw TimeValidationError.invalidSeconds(seconds)
        }
        return seconds % 2 == 0
    }
}

enum TimeValidationError: Error, Equatable {
    case invalidSeconds(UInt)
    
    var localizedDescription: String {
        switch self {
        case .invalidSeconds(let seconds):
            return "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
        }
    }
}
