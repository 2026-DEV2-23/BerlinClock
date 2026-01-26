class BerlinClockEngine {
    
    func isSecondsLampOn(seconds: UInt) -> (isEven: Bool?, error: String?) {
        if !(0...59).contains(seconds) {
            let error = "Invalid seconds: \(seconds). Seconds must be between 0 and 59."
            return (nil, error)
        } else {
            let isEven = (seconds % 2 == 0)
            return (isEven, nil)
        }
    }
    
}
