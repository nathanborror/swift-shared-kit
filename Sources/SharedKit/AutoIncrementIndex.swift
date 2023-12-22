import Foundation

public struct AutoIncrementIndex<Value> {
    private var dict: [UInt64: Value]
    private var currentKey: UInt64
    
    public init() {
        self.dict = [:]
        self.currentKey = 0
    }
    
    public mutating func add(value: Value) -> UInt64 {
        currentKey += 1
        dict[currentKey] = value
        return currentKey
    }
    
    public func get(key: UInt64) -> Value? {
        return dict[key]
    }
    
    public func getAll() -> [UInt64: Value] {
        return dict
    }
}
