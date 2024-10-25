import Foundation

public struct ID<T>: Hashable, Codable, Sendable {
    public var rawValue: String

    public init(_ value: String) {
        self.rawValue = value
    }

    public static var id: Self {
        return .init(.id)
    }
}

extension String {
    
    /// Returns a unique identifier derived from UUID().
    public static var id: String {
        UUID().uuidString
    }
}
