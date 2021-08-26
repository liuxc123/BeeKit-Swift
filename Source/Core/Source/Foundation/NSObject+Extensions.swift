import Foundation

// MARK: - NSObject exntesion

/// This extension adds some useful functions to NSObject.
public extension NSObject {
    // MARK: - Functions
    
    /// Check if the object is valid (not null).
    ///
    /// - Returns: Returns if the object is valid
    func isValid() -> Bool {
        !(self is NSNull)
    }
}
