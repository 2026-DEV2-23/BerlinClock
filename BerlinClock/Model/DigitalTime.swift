struct DigitalTime {
    let hours: UInt
    let minutes: UInt
    let seconds: UInt
    
    init(hours: UInt, minutes: UInt, seconds: UInt) throws {
        guard (0...23).contains(hours) else {
            throw TimeValidationError.invalidHours(hours)
        }
        guard (0...59).contains(minutes) else {
            throw TimeValidationError.invalidMinutes(minutes)
        }
        guard (0...59).contains(seconds) else {
            throw TimeValidationError.invalidSeconds(seconds)
        }
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}
