import os

extension OSLog {
    static let sdk = OSLog(category: "Remote Config SDK")

    private convenience init(category: String, bundle: Bundle = Bundle(for: Logger.self)) {
        let identifier = bundle.infoDictionary?["CFBundleIdentifier"] as? String
        self.init(subsystem: (identifier ?? "").appending(".logs"), category: category)
    }
}

internal class Logger {
    /// Debug
    class func d(_ message: String) {
        #if DEBUG
        print("🔍 \(message)")
        #endif
    }

    /// Error
    class func e(_ message: String) {
        #if DEBUG
        print("💣 \(message)")
        #else
        os_log("%@", log: OSLog.sdk, type: .error, message)
        #endif
    }
}