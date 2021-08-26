import Foundation

// MARK: - Dictionary extension

/// This extension adds some useful functions to Dictionary.
public extension Dictionary {
    // MARK: - Functions
    
    /// Append a Value for a given Key in the Dictionary.
    /// If the Key already exist it will be ovrewritten.
    ///
    /// - Parameters:
    ///   - value: Value to be added.
    ///   - key: Key to be added.
    mutating func append(_ value: Value, forKey key: Key) {
        self[key] = value
    }
}
