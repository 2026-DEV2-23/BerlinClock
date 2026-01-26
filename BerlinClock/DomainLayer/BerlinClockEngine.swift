class BerlinClockEngine {
    
    func convertDigitalTimeToLamp(time: DigitalTime) -> BerlinClockLamp {
        BerlinClockLamp(
            secondsLamp: secondsToLamp(seconds: time.seconds),
            fiveHoursLamp: fiveHoursToLamp(hours: time.hours),
            oneHourLamp: oneHourToLamp(hours: time.hours),
            fiveMinutesLamp: fiveMinutesToLamp(minutes: time.minutes),
            oneMinuteLamp: oneMinuteToLamp(minutes: time.minutes)
        )
    }
    
    private func secondsToLamp(seconds: UInt) -> LampState {
        return seconds % 2 == 0 ? .red : .off
    }
    
    private func fiveHoursToLamp(hours: UInt) -> [LampState] {
        let lamps = hours / 5
        return (0..<4).map { $0 < lamps ? .red : .off }
    }
    
    private func oneHourToLamp(hours: UInt) -> [LampState] {
        let lamps = hours % 5
        return (0..<4).map { $0 < lamps ? .red : .off }
    }
    
    private func fiveMinutesToLamp(minutes: UInt) -> [LampState] {
        let lamps = minutes / 5
        return (0..<11).map {
            if $0 < lamps {
                return ($0 + 1) % 3 == 0 ? .red : .yellow
            }
            return .off
        }
    }
    
    private func oneMinuteToLamp(minutes: UInt) -> [LampState] {
        let lamps = minutes % 5
        return (0..<4).map { $0 < lamps ? .yellow : .off }
    }
    
}
