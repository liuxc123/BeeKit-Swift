import UIKit

public class LinearLayout {
    var spacingChanged: (((constant: CGFloat, identifier: String)) -> Void)?
    var completed: (() -> Void)?
    
    let axis: NSLayoutConstraint.Axis
    var items: [() -> Item] = []
    var spaces: [Int: [Space]] = [:]
    
    /// Initialization function
    /// - Parameter axis: A stack with a horizontal axis is a row of arrangedSubviews, and a stack with a vertical axis is a column of arrangedSubviews.
    public init(_ axis: NSLayoutConstraint.Axis = .vertical) {
        self.axis = axis
    }
    
    @discardableResult
    public func view(_ value: UIView) -> Self {
        return view(.init(value, layout: .automatic(leading: 0, trailing: 0)))
    }
    
    @discardableResult
    public func view(_ value: Item) -> Self {
        return view { value }
    }
    
    @discardableResult
    public func views(_ value: [UIView]) -> Self {
        value.forEach { view($0) }
        return self
    }
    
    @discardableResult
    public func views(_ value: [Item]) -> Self {
        value.forEach { view($0) }
        return self
    }
    
    @discardableResult
    public func view(_ closure: @escaping () -> Item) -> Self {
        items.append(closure)
        return self
    }
    
    /// Spacing between adjacent edges of arrangedSubviews.
    /// Used as a minimum spacing for the fixed size.
    ///
    /// - Parameters:
    ///   - value: spacing      Greater than or equal to zero
    ///   - mode: mode      The default is .fixed
    ///   - identifier: identifier
    /// - Returns: LinearLayout
    @discardableResult
    public func spacing(_ value: CGFloat, mode: Space.Mode = .fixed, identifier: String? = .none) -> Self {
        guard value >= 0 else { return self }
        
        let key = items.count
        var temp = spaces[key] ?? []
        temp.append(.init(constant: value, mode: mode, identifier: identifier))
        spaces[key] = temp
        return self
    }
    
    /// Complete layout configuration
    /// - Returns: LinearLayout
    @discardableResult
    public func done() -> Self {
        completed?()
        return self
    }
}

extension LinearLayout {
    
    public func update(spacing value: CGFloat, for identifier: String) {
        for (key, var array) in spaces {
            for (index, var space) in array.enumerated() where space.identifier == identifier {
                space.constant = value
                array[index] = space
                spaces[key] = array
            }
        }
        spacingChanged?((value, identifier))
    }
}

extension LinearLayout {
    
    public struct Alignment {
        
        let value: Int
        var offset: CGFloat?
        
        /// Center the items in a vertical stack horizontally or the items in a horizontal stack vertically
        public static var center: Alignment = .init(value: 0)
        
        /// Align the leading edges of vertically stacked items or the top edges of horizontally stacked items tightly to the relevant edge of the container
        public static var leading: Alignment = .init(value: 1)
        
        /// Align the trailing edges of vertically stacked items or the bottom edges of horizontally stacked items tightly to the relevant edge of the container
        public static var trailing: Alignment = .init(value: 2)
        
        /// Center the items in a vertical stack horizontally or the items in a horizontal stack vertically
        /// - Parameter offset: Center offset
        /// - Returns: Alignment
        public static func center(_ offset: CGFloat) -> Alignment {
            var temp = center
            temp.offset = offset
            return temp
        }
        
        /// Align the leading edges of vertically stacked items or the top edges of horizontally stacked items tightly to the relevant edge of the container
        /// - Parameter inset: padding
        /// - Returns: Alignment
        public static func leading(_ inset: CGFloat) -> Alignment {
            var temp = leading
            temp.offset = inset
            return temp
        }
        
        /// Align the trailing edges of vertically stacked items or the bottom edges of horizontally stacked items tightly to the relevant edge of the container
        /// - Parameter inset: padding
        /// - Returns: Alignment
        public static func trailing(_ inset: CGFloat) -> Alignment {
            var temp = trailing
            temp.offset = inset
            return temp
        }
    }
    
    public enum Option {
        /// The width of the vertically stacked items or the height of the horizontally stacked items and the alignment of the items.
        case constant(CGFloat, Alignment)
        /// Align the leading trailing edges of vertically stacked items or the top bottom edges of horizontally stacked items tightly to the relevant edge of the container
        case automatic(leading: CGFloat, trailing: CGFloat)
    }
    
    public struct Item {
        let view: UIView
        let layout: Option
        
        public init(_ view: UIView, layout: Option = .automatic(leading: 0, trailing: 0)) {
            self.view = view
            self.layout = layout
        }
    }
    
    public struct Space {
        var constant: CGFloat
        let mode: Mode
        let identifier: String?
    }
}

extension LinearLayout.Space {
    
    public enum Mode {
        /// Nothing changes when the adjacent view is hidden
        case fixed
        
        /// When the adjacent view is hidden, the spacing will disappear with the view
        case follow
    }
}

