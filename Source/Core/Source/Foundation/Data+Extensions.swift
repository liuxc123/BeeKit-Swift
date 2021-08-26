import Foundation

// MARK: - Data extension

/// This extension add some useful functions to Data.
public extension Data {
    // MARK: - Functions
    
    /// Convert self to a UTF8 String.
    ///
    /// - Returns: Returns self as UTF8 NSString.
    func utf8() -> String? {
        String(data: self, encoding: .utf8)
    }
    
    /// Convert self to a ASCII String.
    ///
    /// - Returns: Returns self as ASCII String.
    func ascii() -> String? {
        String(data: self, encoding: .ascii)
    }
    
    /// Convert self UUID to String.
    ///
    /// Useful for push notifications.
    ///
    /// - Returns: Returns self as String from UUID.
    func readableUUID() -> String {
        description.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
    }
}
