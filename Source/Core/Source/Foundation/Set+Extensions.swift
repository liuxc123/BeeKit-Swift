import Foundation

// MARK: - Set extension

/// This extension adds some useful functions to Set.
public extension Set {
    /// Randomly selects an element from self and returns it.
    ///
    /// - returns: An element that was randomly selected from the set.
    func random() -> Element {
        let randomOffset = Int.random(in: 0...count - 1)
        return self[index(startIndex, offsetBy: randomOffset)]
    }
}
