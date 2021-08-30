import UIKit

public struct LimitInput {
    // 字数限制
    public static var wordLimit: Int = Int.max
    // 表情限制
    public static var emojiLimit: Bool = false
    // 文本替换 保证光标位置
    public static var replaces: [LimitInputReplace] = []
    // 判断输入是否合法的
    public static var matchs: [LimitInputMatch] = []
    // 菜单禁用项
    public static var disables: [LimitInputDisableState] = []
    // 文字超出字符限制事件
    public static var overWordLimitEvent: ((_ text: String)->())? = nil
    // 表情限制事件
    public static var emojiLimitEvent: ((String) -> ())? = nil
}

