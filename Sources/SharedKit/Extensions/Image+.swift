#if os(macOS)
import AppKit
public typealias PlatformImage = NSImage
#else
import UIKit
public typealias PlatformImage = UIImage
#endif

public enum ResizeStrategy {
    case scaleToFit
    case scaleToFill
    case stretch
}

extension PlatformImage {

    public func resize(width: CGFloat, height: CGFloat, strategy: ResizeStrategy = .scaleToFit, quality: CGInterpolationQuality = .high) -> PlatformImage? {
        let targetSize = CGSize(width: width, height: height)
        let finalSize: CGSize
        let drawRect: CGRect

        switch strategy {
        case .scaleToFit:
            let scaleFactor = calculateScaleToFitFactor(for: targetSize)
            finalSize = CGSize(
                width: self.size.width * scaleFactor,
                height: self.size.height * scaleFactor
            )
            drawRect = CGRect(origin: .zero, size: finalSize)

        case .scaleToFill:
            finalSize = targetSize
            let scaleFactor = calculateScaleToFillFactor(for: targetSize)
            let scaledSize = CGSize(
                width: self.size.width * scaleFactor,
                height: self.size.height * scaleFactor
            )
            let x = (scaledSize.width - targetSize.width) * 0.5
            let y = (scaledSize.height - targetSize.height) * 0.5
            drawRect = CGRect(
                x: -x,
                y: -y,
                width: scaledSize.width,
                height: scaledSize.height
            )

        case .stretch:
            finalSize = targetSize
            drawRect = CGRect(origin: .zero, size: targetSize)
        }

        #if os(macOS)
        return resizeMacOS(size: finalSize, drawRect: drawRect, quality: quality)
        #else
        return resizeIOS(size: finalSize, drawRect: drawRect, quality: quality)
        #endif
    }

    private func calculateScaleToFitFactor(for targetSize: CGSize) -> CGFloat {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        return min(widthRatio, heightRatio)
    }

    private func calculateScaleToFillFactor(for targetSize: CGSize) -> CGFloat {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        return max(widthRatio, heightRatio)
    }
}

#if os(macOS)
extension PlatformImage {

    public func pngData() -> Data? {
        guard let tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else {
            return nil
        }
        return bitmapImage.representation(using: .png, properties: [:])
    }

    private func resizeMacOS(size: CGSize, drawRect: CGRect, quality: CGInterpolationQuality) -> NSImage? {
        autoreleasepool {
            let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
            let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue

            guard let context = CGContext(
                data: nil,
                width: Int(size.width),
                height: Int(size.height),
                bitsPerComponent: 8,
                bytesPerRow: 0,
                space: colorSpace,
                bitmapInfo: bitmapInfo
            ) else { return nil }

            context.interpolationQuality = quality

            let graphicsContext = NSGraphicsContext(cgContext: context, flipped: false)
            NSGraphicsContext.current = graphicsContext

            draw(in: drawRect,
                 from: CGRect(origin: .zero, size: self.size),
                 operation: .copy,
                 fraction: 1.0)

            guard let cgImage = context.makeImage() else { return nil }
            return NSImage(cgImage: cgImage, size: size)
        }
    }
}
#else
extension PlatformImage {

    private func resizeIOS(size: CGSize, drawRect: CGRect, quality: CGInterpolationQuality) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.preferredRange = .standard

        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.image { context in
            context.cgContext.interpolationQuality = quality
            context.cgContext.setRenderingIntent(.relativeColorimetric)
            draw(in: drawRect)
        }
    }
}
#endif
