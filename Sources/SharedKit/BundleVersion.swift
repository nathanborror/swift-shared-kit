import Foundation

public struct BundleVersion {
    public static var shared = BundleVersion()
    
    public var bundleVersion: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    public var storedBundleVersion: String? {
        UserDefaults.standard.string(forKey: bundleVersionKey)
    }
    
    public func setBundleVersion() {
        UserDefaults.standard.set(bundleVersion, forKey: bundleVersionKey)
    }

    public func isBundleVersionNew() -> Bool {
        if storedBundleVersion == nil {
            setBundleVersion()
            return true
        }
        if storedBundleVersion != bundleVersion {
            setBundleVersion()
            return true
        }
        return false
    }
    
    var bundleVersionKey = "bundle.version"
}
