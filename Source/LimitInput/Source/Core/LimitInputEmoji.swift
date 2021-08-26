//
//  LimitInputEmoji.swift
//  LimitInputEmoji
//
//  Created by mac on 2021/8/24.
//

import Foundation

extension Character {
    /// 简单的emoji是一个标量，以emoji的形式呈现给用户
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else {
            return false
        }
        if #available(iOS 10.2, *) {
            return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
        } else {
            for scalar in unicodeScalars {
                switch scalar.value {
                case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x1F1E6...0x1F1FF, // Regional country flags
                0x2600...0x26FF, // Misc symbols
                0x2700...0x27BF, // Dingbats
                0xE0020...0xE007F, // Tags
                0xFE00...0xFE0F, // Variation Selectors
                0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                127000...127600, // Various asian characters
                65024...65039, // Variation selector
                9100...9300, // Misc items
                8400...8447: // Combining Diacritical Marks for Symbols
                    return true
                default:
                    continue
                }
            }
            return false
        }
    }
    
    /// 检查标量是否将合并到emoji中
    var isCombinedIntoEmoji: Bool {
        if #available(iOS 10.2, *) {
            return unicodeScalars.count > 1 &&
            unicodeScalars.first?.properties.isEmoji ?? false
        } else {
            return false
        }
    }

    var isEmoji: Bool {
        return isSimpleEmoji || isCombinedIntoEmoji
    }
}

extension String {
    /// 是否为单个emoji表情
    var isSingleEmoji: Bool {
        return count == 1 && containsEmoji
    }

    /// 包含emoji表情
    var containsEmoji: Bool {
        return contains { $0.isEmoji }
    }

    /// 只包含emoji表情
    var containsOnlyEmoji: Bool {
        return !isEmpty && !contains { !$0.isEmoji }
    }

    /// 提取emoji表情字符串
    var emojiString: String {
        return emojis.map{String($0) }.reduce("",+)
    }

    /// 提取emoji表情数组
    var emojis: [Character] {
        return filter{ $0.isEmoji }
    }

    /// 提取单元编码标量
    var emojiScalars: [UnicodeScalar] {
        return filter{ $0.isEmoji }.flatMap{ $0.unicodeScalars }
    }
}
