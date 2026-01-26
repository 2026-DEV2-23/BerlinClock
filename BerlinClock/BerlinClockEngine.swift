class BerlinClockEngine {
    
    func isSecondsLampOn(seconds: UInt) -> (isEven: Bool?, error: String?) {
        if seconds > 59 {
            let error = "Invalid seconds: \(seconds). Seconds should not be more than 59."
            return (nil, error)
        } else {
            let isEven = (seconds % 2 == 0)
            return (isEven, nil)
        }
    }
    
}
