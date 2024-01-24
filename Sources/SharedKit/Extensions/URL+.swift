import Foundation

extension URL {
    
    public var queryParameters: [String: String] {
        get {
            guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems else {
                return [:]
            }
            return components.reduce(into: [String: String]()) { (result, item) in
                result[item.name] = item.value
            }
        }
        set {
            var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
            components?.queryItems = newValue.map { URLQueryItem(name: $0.key, value: $0.value) }
            self = components?.url ?? self
        }
    }
}
