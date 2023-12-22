import Foundation

public protocol Persistence {
    func load<T: Codable>(objects: String) async throws -> [T]
    func load<T: Codable>(object filename: String) async throws -> T?
    
    func save<T: Codable>(filename: String, objects: [T]) async throws
    func save<T: Codable>(filename: String, object: T) async throws
    
    func delete(filename: String) throws
    func deleteAll() throws
}
