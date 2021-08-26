import Foundation

public class Bee<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
    public var build: Base {
        return base
    }
}

public protocol BeeCompatible {
    associatedtype CompatibleType
    var bee: CompatibleType { get }
}
extension BeeCompatible {
    public var bee: Bee<Self> {
        return Bee(self)
    }
}

extension NSObject: BeeCompatible {}


