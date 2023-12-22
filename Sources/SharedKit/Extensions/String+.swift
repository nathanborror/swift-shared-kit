import Foundation

extension String? {
    
    public func patch(with patch: String?) -> String? {
        guard let patch = patch else { return self }
        if let existing = self {
            return existing + patch
        } else {
            return patch
        }
    }
}

extension String {
    
    public func patch(with patch: String?) -> String {
        guard let patch = patch else { return self }
        return self + patch
    }
}

extension String {
    
    public static var id: String {
        UUID().uuidString
    }
}
