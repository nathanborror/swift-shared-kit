import Foundation
#if os(macOS)
import AppKit
#endif

#if os(macOS)
extension NSImage {
    
    public func pngData() -> Data? {
        guard let tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else {
            return nil
        }
        
        return bitmapImage.representation(using: .png, properties: [:])
    }
}
#endif
