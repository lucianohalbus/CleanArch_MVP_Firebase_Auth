import Foundation


public protocol Model: Equatable, Codable {}


public extension Model {
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

