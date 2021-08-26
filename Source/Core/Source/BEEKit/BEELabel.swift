//
//  BEELabel.swift
//  BeeKit-Swift
//
//  Created by liuxc on 2021/1/29.
//

import UIKit

public class BEELabel: UILabel {

    /// 设置文本内边距
    public var textInsets: UIEdgeInsets = .zero

    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = textInsets
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }

}
