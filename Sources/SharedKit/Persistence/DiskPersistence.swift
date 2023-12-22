import Foundation

public class DiskPersistence: Persistence {

    public static var shared = DiskPersistence()
    
    init() {}
    
    var documents: URL? {
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    public func load<T: Codable>(objects filename: String) async throws -> [T] {
        guard let url = documents?.appending(path: filename, directoryHint: .notDirectory) else {
            return []
        }
        guard FileManager.default.fileExists(atPath: url.path) else {
            return []
        }
        let task = Task<[T], Error> {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([T].self, from: data)
        }
        return try await task.value
    }
    
    public func load<T: Codable>(object filename: String) async throws -> T? {
        guard let url = documents?.appending(path: filename, directoryHint: .notDirectory) else {
            return nil
        }
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        let task = Task<T?, Error> {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        }
        return try await task.value
    }

    public func save<T: Codable>(filename: String, objects: [T]) async throws {
        guard let url = documents?.appending(path: filename, directoryHint: .notDirectory) else {
            return
        }
        let task = Task {
            let data = try JSONEncoder().encode(objects)
            try data.write(to: url)
        }
        _ = try await task.value
    }
    
    public func save<T: Codable>(filename: String, object: T) async throws {
        guard let url = documents?.appending(path: filename, directoryHint: .notDirectory) else {
            return
        }
        let task = Task {
            let data = try JSONEncoder().encode(object)
            try data.write(to: url)
        }
        _ = try await task.value
    }
    
    public func delete(filename: String) throws {
        guard let url = documents?.appending(path: filename, directoryHint: .notDirectory) else {
            return
        }
        try FileManager.default.removeItem(at: url)
    }
    
    public func deleteAll() throws {
        guard let dir = documents else { return }
        let files = try FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)
        for url in files {
            try FileManager.default.removeItem(at: url)
        }
    }
}
