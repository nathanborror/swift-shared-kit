import Foundation

extension KeyedDecodingContainer {

    /// Convenience function to decode into a raw JSON string.
    public func decodeRawJSON(forKey key: K) throws -> String {
        let data = try decodeIfPresent(Data.self, forKey: key) ?? Data()
        if let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Unable to decode JSON as a string.")
        }
    }
}
