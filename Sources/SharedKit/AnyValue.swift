import Foundation

public enum AnyValue: Codable {
    case string(String)
    case int(Int)
    case float(Double)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let v = try? container.decode(Int.self) {
            self = .int(v)
            return
        }
        if let v = try? container.decode(Double.self) {
            self = .float(v)
            return
        }
        if let v = try? container.decode(String.self) {
            self = .string(v)
            return
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode AnyValue")
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let v):
            try container.encode(v)
        case .int(let v):
            try container.encode(v)
        case .float(let v):
            try container.encode(v)
        }
    }
}
