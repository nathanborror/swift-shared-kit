import Foundation

public enum AnyValue: Codable {
    case string(String)
    case int(Int)
    case float(Double)
    case array(AnyValueArray)
    case object(AnyValueObject)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let v = try? container.decode(Int.self) {
            self = .int(v)
        } else if let v = try? container.decode(Double.self) {
            self = .float(v)
        } else if let v = try? container.decode(String.self) {
            self = .string(v)
        } else if let v = try? container.decode(AnyValueArray.self) {
            self = .array(v)
        } else if let v = try? container.decode(AnyValueObject.self) {
            self = .object(v)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode AnyValue")
        }
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
        case .array(let v):
            try container.encode(v)
        case .object(let v):
            try container.encode(v)
        }
    }
}

public struct AnyValueArray: Codable {
    public var values: [AnyValue]
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var values = [AnyValue]()
        
        while !container.isAtEnd {
            let value = try container.decode(AnyValue.self)
            values.append(value)
        }
        
        self.values = values
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for value in values {
            try container.encode(value)
        }
    }
}

public struct AnyValueObject: Codable {
    public var values: [String: AnyValue]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var values = [String: AnyValue]()
        
        for key in container.allKeys {
            let value = try container.decode(AnyValue.self, forKey: key)
            values[key.stringValue] = value
        }
        
        self.values = values
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        for (key, value) in values {
            try container.encode(value, forKey: CodingKeys(stringValue: key)!)
        }
    }
    
    struct CodingKeys: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? {
            return nil
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
}
