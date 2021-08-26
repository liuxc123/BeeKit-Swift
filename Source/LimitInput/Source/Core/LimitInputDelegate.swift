import UIKit

public class LimitInputDelegate: NSObject {
    private(set) weak var textInputDelegate: AnyObject?

    public init(delegate: AnyObject?) {
        self.textInputDelegate = delegate
    }
}
