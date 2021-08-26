//
//  BEELog.swift
//  BeeKit
//
//  Created by liuxc on 2021/1/12.
//

import CocoaLumberjack

extension DDLogFlag {
    public var level: String {
        switch self {
        case DDLogFlag.error: return "🐲❤️ ERROR"
        case DDLogFlag.warning: return "🐲💛 WARNING"
        case DDLogFlag.info: return "🐲💙 INFO"
        case DDLogFlag.debug: return "🐲💚 DEBUG"
        case DDLogFlag.verbose: return "🐲💜 VERBOSE"
        default: return "🐲☠️ UNKNOWN"
        }
    }
}

private class LogFormatter: NSObject, DDLogFormatter {

    static let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }

    public func format(message logMessage: DDLogMessage) -> String? {
        let timestamp = LogFormatter.dateFormatter.string(from: logMessage.timestamp)
        let level = logMessage.flag.level
        let filename = logMessage.fileName
        let function = logMessage.function ?? ""
        let line = logMessage.line
        let message = logMessage.message.components(separatedBy: "\n").joined(separator: "\n    ")
        return "\(timestamp) \(level) \(filename).\(function):\(line) - \(message)"
    }

    private func formattedDate(from date: Date) -> String {
        return LogFormatter.dateFormatter.string(from: date)
    }

}

// MARK: - Global functions

/// A shared instance of `BEELog`.
public let log = BEELog()

public class BEELog {

    // MARK: Initialize

    init() {

        if #available(iOS 10.0, *) {
            DDOSLogger.sharedInstance.do {
                $0.logFormatter = LogFormatter()
                DDLog.add($0)
            }
        } else {
            DDTTYLogger.sharedInstance?.do {
                $0.logFormatter = LogFormatter()
                DDLog.add($0)
            }
        } // Uses os_log

        // File logger
        DDFileLogger().do {
            $0.logFormatter = LogFormatter()
            $0.rollingFrequency = TimeInterval(60 * 60 * 24)  // 24 hours
            $0.logFileManager.maximumNumberOfLogFiles = 7
            DDLog.add($0)
        }
    }


    // MARK: - Functions

    public func error(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) {
        let message = self.message(from: items)
        DDLogError(message, file: file, function: function, line: line)
    }

    public func warning(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) {
        let message = self.message(from: items)
        DDLogWarn(message, file: file, function: function, line: line)
    }

    public func info(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) {
        let message = self.message(from: items)
        DDLogInfo(message, file: file, function: function, line: line)
    }

    public func debug(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) {
        let message = self.message(from: items)
        DDLogDebug(message, file: file, function: function, line: line)
    }

    public func verbose(
        _ items: Any...,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) {
        let message = self.message(from: items)
        DDLogVerbose(message, file: file, function: function, line: line)
    }


    // MARK: Utils

    private func message(from items: [Any]) -> String {
        return items
            .map { String(describing: $0) }
            .joined(separator: " ")
    }
}
