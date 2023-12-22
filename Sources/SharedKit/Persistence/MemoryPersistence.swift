import Foundation

public class MemoryPersistence: Persistence {
    
    public static var shared = MemoryPersistence()
    
    public func load<T: Codable>(objects: String) async throws -> [T]  {
        return []
    }
    
    public func load<T: Codable>(object filename: String) async throws -> T?  {
        return nil
    }
    
    public func save<T: Codable>(filename: String, objects: [T]) async throws  {}
    public func save<T: Codable>(filename: String, object: T) async throws  {}
    public func delete(filename: String) throws {}
    public func deleteAll() throws {}
}
