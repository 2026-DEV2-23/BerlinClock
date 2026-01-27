import Foundation

protocol DigitalTimeProviderProtocol {
    func getDigitalTime(from date: Date) throws -> DigitalTime
}
