import Foundation

extension Date {
    
    public init?(string: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    public func format(as format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
