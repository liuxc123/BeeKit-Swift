import Foundation

// MARK: - ProcessInfo extension

/// This extesion adds some useful functions to ProcessInfo.
public extension ProcessInfo {
    /// Returns system uptime.
    ///
    /// - Returns: eturns system uptime.
    static func uptime() -> TimeInterval {
        ProcessInfo.processInfo.systemUptime
    }
    
    /// Returns sysyem uptime as Date.
    ///
    /// - Returns: Returns sysyem uptime as Date.
    static func uptimeDate() -> Date {
        Date(timeIntervalSinceNow: -uptime())
    }
}
