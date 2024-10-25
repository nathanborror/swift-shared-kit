import Foundation

extension String? {

    /// Returns the current string with the given patch appended or nil of neither don't exist.
    public func apply(with patch: String?) -> String? {
        if let existing = self {
            return existing + (patch ?? "")
        } else {
            return patch
        }
    }
}

extension String {
    
    /// Returns the current string with the given patch appended if it exists.
    public func apply(with patch: String?) -> String {
        guard let patch else { return self }
        return self + patch
    }
    
    /// Returns a string with all occurrences of `{variable_names}` replaced with the give values in the context dictionary.
    public func apply(context: [String: any StringProtocol]) -> String {
        var out = self
        for (key, value) in context {
            out = out.replacingOccurrences(of: "{\(key)}", with: value)
        }
        return out
    }
}
