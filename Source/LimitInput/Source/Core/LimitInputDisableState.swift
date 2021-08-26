import UIKit

/// 禁用状态
///
/// - cut: 剪切
/// - copy: 复制
/// - paste: 粘贴
/// - select: 选择
/// - selectAll: 全选
/// - delete: 删除
/// - makeTextWritingDirectionLeftToRight: 改变书写模式为从左向右按
/// - makeTextWritingDirectionRightToLeft: 改变书写模式为从右向左按钮
/// - toggleBoldface: 切换字体为黑体(粗体)
/// - toggleItalics: 切换字体为斜体
/// - toggleUnderline: 给文字添加下划线
/// - increaseSize: 增加字体大小
/// - decreaseSize: 减小字体大小
/// - promptForReplace: 替换
/// - transliterateChinese: 简体繁体转换
/// - insertDrawing: insertDrawing description
/// - showTextStyleOptions: 文字风格
/// - lookup: 查找來源
/// - define: 定义
/// - addShortcut: 添加捷径
/// - accessibilitySpeak: 朗读
/// - accessibilitySpeakLanguageSelection: 语言选择按钮
/// - accessibilityPauseSpeaking: 暂停朗读
/// - share: 分享
public enum LimitInputDisableState: String,CaseIterable {
    case cut = "cut:"
    case copy = "copy:"
    case paste = "paste:"
    case select = "select:"
    case selectAll = "selectAll:"
    case delete = "delete:"
    case makeTextWritingDirectionLeftToRight = "makeTextWritingDirectionLeftToRight:"
    case makeTextWritingDirectionRightToLeft = "makeTextWritingDirectionRightToLeft:"
    case toggleBoldface = "toggleBoldface:"
    case toggleItalics = "toggleItalics:"
    case toggleUnderline = "toggleUnderline:"
    case increaseSize = "increaseSize:"
    case decreaseSize = "decreaseSize:"
    case promptForReplace = "_promptForReplace:"
    case transliterateChinese = "_transliterateChinese:"
    case insertDrawing = "_insertDrawing:"
    case showTextStyleOptions = "_showTextStyleOptions:"
    case lookup = "_lookup:"
    case define = "_define:"
    case addShortcut = "_addShortcut:"
    case accessibilitySpeak = "_accessibilitySpeak:"
    case accessibilitySpeakLanguageSelection = "_accessibilitySpeakLanguageSelection:"
    case accessibilityPauseSpeaking = "_accessibilityPauseSpeaking:"
    case share = "_share:"
    case insertTextFromCamera = "_insertTextFromCamera:"
}



