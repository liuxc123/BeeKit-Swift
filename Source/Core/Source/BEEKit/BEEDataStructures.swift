import Foundation

// MARK: - List struct

/// Primitive List implementation.
public struct List<Element: Equatable>: CustomStringConvertible {
    // MARK: - Variables

    /// Count of the elements in list.
    public var count: Int {
        list.count
    }

    /// Describe the List.
    public var description: String {
        "\(list)"
    }

    /// The array behind the List.
    private var list = [Element]()

    // MARK: - Functions

    /// Delete an element at the given index.
    ///
    /// - Parameter index: The index to delete.
    public mutating func delete(at index: Int) {
        list.remove(at: index)
    }

    /// Delete an element in the List.
    ///
    /// - Parameter element: The object to be deleted.
    /// - Returns: Retruns true if removed, otherwise false.
    public mutating func delete(_ element: Element) -> Bool {
        let firstElement = search(element)

        guard firstElement > -1 else {
            return false
        }

        list.remove(at: firstElement)
        return true
    }

    /// Insert an element in the List.
    ///
    /// - Parameter element: The element to insert in the List.
    public mutating func insert(_ element: Element) {
        list.append(element)
    }

    /// Search for an index and returns the element.
    ///
    /// - Parameter index: The index.
    /// - Returns: Returns the element of the searched index.
    public func search(at index: Int) -> Element? {
        list.safeObject(at: index)
    }

    /// Search an element and returns the index.
    ///
    /// - Parameter element: The element to search.
    /// - Returns: Returns the index of the searched element.
    public func search(_ element: Element) -> Int {
        for index in 0 ..< list.count where list[index] == element {
            return index
        }

        return -1
    }

    public init() {}
}

// MARK: - Queue struct

/// Primitive Queue implementation.
public struct Queue<Element: Equatable>: CustomStringConvertible {
    // MARK: - Variables

    /// Count of the elements in list.
    public var count: Int {
        queue.count
    }

    /// Describe the Queue.
    public var description: String {
        "\(queue)"
    }

    /// The array behind the Queue.
    private var queue = [Element]()

    // MARK: - Functions

    /// Dequeue the first element.
    ///
    /// - Returns: Retruns true if removed, otherwise false.
    public mutating func dequeue() -> Bool {
        if !queue.isEmpty {
            queue.remove(at: 0)
            return true
        }

        return false
    }

    /// Remove all the elements in the Queue.
    public mutating func empty() {
        queue.removeAll(keepingCapacity: false)
    }

    /// Adds an element to the Queue.
    ///
    /// - Parameter element: The element to add.
    public mutating func enqueue(_ element: Element) {
        queue.append(element)
    }

    /// Returns the Queue top element.
    ///
    /// - Returns: Returns the Queue top element.
    public func top() -> Element? {
        queue.first
    }

    public init() {}
}

// MARK: - Stack struct

/// Primitive Stack implementation.
public struct Stack<Element: Equatable>: CustomStringConvertible {
    // MARK: - Variables

    /// Count of the elements in list.
    public var count: Int {
        stack.count
    }

    /// Describe the Stack.
    public var description: String {
        "\(stack)"
    }

    /// The array behind Stack.
    private var stack = [Element]()

    // MARK: - Functions

    /// Returns if the Stack is empty or not.
    ///
    /// - Returns: Returns true if the Stack is empty, otherwise false.
    public func empty() -> Bool {
        stack.isEmpty
    }

    /// Removes an element on top of the Stack.
    ///
    /// - Returns: Returns the removed element.
    public mutating func pop() -> Element? {
        var element: Element?
        if !empty() {
            element = stack[stack.count - 1]
            stack.remove(at: stack.count - 1)
        }

        return element
    }

    /// Adds an element on top of the Stack.
    ///
    /// - Parameter element: The element to add.
    public mutating func push(_ element: Element) {
        stack.append(element)
    }

    public init() {}
}

