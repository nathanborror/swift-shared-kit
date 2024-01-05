import Foundation

extension String? {
    
    public func apply(with patch: String?) -> String? {
        if let existing = self {
            return existing + (patch ?? "")
        } else {
            return patch
        }
    }
}

extension String {
    
    public func apply(with patch: String?) -> String {
        guard let patch else { return self }
        return self + patch
    }
}

extension String {
    
    public static var id: String {
        UUID().uuidString
    }
}
