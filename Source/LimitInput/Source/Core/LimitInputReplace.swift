import UIKit

public struct LimitInputReplace {

    var key: String = ""
    var value: String = ""

    var chars = [Character]()
    var offset: Int { return value.count - key.count }

    public init(from: String, of: String) {
        self.key = from
        self.value = of
        self.chars = from.map({ (char) -> Character in
            return char
        })
    }

}
