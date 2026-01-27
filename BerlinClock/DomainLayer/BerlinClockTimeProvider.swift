import Foundation

class BerlinClockTimeProvider: DigitalTimeProviderProtocol {
    func getDigitalTime(from date: Date) throws -> DigitalTime {
        
        // since hours, minutes and seconds can't be negative as retrieved from Date hence converting Int to UInt
        return try DigitalTime(
            hours: UInt(Calendar.current.component(.hour, from: date)),
            minutes: UInt(Calendar.current.component(.minute, from: date)),
            seconds: UInt(Calendar.current.component(.second,from: date))
        )
    }
}
