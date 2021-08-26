/***** 模块文档 *****
 * IconFont 协议 
 * 使用swift_iconfont.py 脚本生成图标文件
 */

import Foundation
import UIKit

public protocol IconFontProtocol{
    var size:CGFloat { get }
    var text:String { get }
    var font:UIFont { get }
    var attributedString:NSAttributedString { get }
    
    func attributedString(withColor fg:UIColor) -> NSAttributedString
    func attributedString(withColor fg:UIColor, bg:UIColor?) -> NSAttributedString
    func attributedString(withAttributes a:[NSAttributedString.Key : Any]?) -> NSAttributedString
}

public extension IconFontProtocol {
    var attributedString:NSAttributedString {
        return self.attributedString(withAttributes:nil)
    }
    
    func attributedString(withColor fg:UIColor) -> NSAttributedString {
        return self.attributedString(withColor:fg, bg: nil)
    }
    
    func attributedString(withColor fg:UIColor, bg:UIColor?) -> NSAttributedString {
        var attributes:[NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : fg]
        if (bg != nil) {
            attributes[NSAttributedString.Key.backgroundColor] = bg!
        }
        return self.attributedString(withAttributes:attributes)
    }
    func attributedString(withAttributes a:[NSAttributedString.Key : Any]?) -> NSAttributedString {
        var attributes = a ?? [:]
        attributes[NSAttributedString.Key.font] = self.font
        return NSAttributedString(string: self.text, attributes: attributes)
    }
}



public extension UILabel {
    func iconfont(_ font:IconFontProtocol) {
        self.font = font.font
        self.text = font.text
    }
}

public extension UIButton {
    enum IconFontStyle {
        case text(_ state:UIControl.State?)
        case image(_ state:UIControl.State?, color:UIColor?)
        case bgImage(_ state:UIControl.State?, color:UIColor?)
    }
    func iconfont(_ font:IconFontProtocol, style:IconFontStyle = .text(.normal)) {
        switch style {
        case let .text(state):
            self.titleLabel?.font = font.font
            self.setTitle(font.text, for: state ?? .normal)
        case let .image(state, color):
            self.setImage(UIImage.iconfont(font, color:color ?? self.tintColor), for: state ?? .normal)
        case let .bgImage(state, color):
            self.setBackgroundImage(UIImage.iconfont(font, color:color ?? self.tintColor), for: state ?? .normal)
        }
    }
}

public extension UIImageView {
    func iconfont(_ font:IconFontProtocol, color: UIColor = UIColor.black) {
        self.image = UIImage.iconfont(font, color:color)
    }
}

public extension UIImage {
    @discardableResult
    static func iconfont(_ font:IconFontProtocol, color:UIColor, point:CGPoint = .zero) -> UIImage {
        let scale = UIScreen.main.scale
        let size = font.size
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size),false,0)
        NSString(string: font.text).draw(at: point, withAttributes: [NSAttributedString.Key.font : font.font, NSAttributedString.Key.foregroundColor:color])
        
        guard let imageCG:CGImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage  else {
            assertionFailure("👉👉👉CGImage - 失败  👻")
            return UIImage()
        }
        let image = UIImage(cgImage: imageCG, scale: scale, orientation: UIImage.Orientation.up)
        UIGraphicsEndImageContext()
        return image
    }
}


public extension UIFont {

    //MARK:--- IconFont ----------
    /*
     ///IconFont 未使用pod 管理，需要在info.plist 中添加 Fonts provided by application
     static func iconFont(name:String, size:CGFloat) -> UIFont {
         guard let font = UIFont(name: name, size: size) else {
             assertionFailure("👉👉👉IconFont-请确认\(name).ttf 和 font-family是否配置正确  👻")
             return UIFont.systemFont(ofSize: size)
         }
     return font
     }*/

    ///IconFont name:font-family forClass:class  from: pod resource_bundles key
    static func iconFont(_ name:String, size:CGFloat, forClass:AnyClass? = nil, from:String? = nil) -> UIFont {
        if let clas = forClass,  let bu = Bundle.bundle(clas, from) {
            let path = String(format: "%@/%@.ttf", bu.bundlePath, name)
            return UIFont.iconFont(name, size: size, url:URL(fileURLWithPath: path))
        }
        else if let font = UIFont(name: name, size: size){
            return font
        }
        else{
            // 如果info.plist没有添加 Fonts provided by application 则可以直接检索 Bundle 读取
            guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else {
                assertionFailure("👉👉👉IconFont-请确认\(name).ttf 和 font-family是否配置正确  👻")
                return UIFont.systemFont(ofSize: size)
            }
            return UIFont.iconFont(name, size: size, url:url)
        }
    }

    ///IconFont name:font-family url: Bundle url
    static func iconFont(_ name:String, size:CGFloat, url:URL) -> UIFont {
        guard let data = try? Data(contentsOf: url) else {
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        guard let provider = CGDataProvider.init(data: data as CFData) else {
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        guard let fontCG = CGFont(provider) else{
            assertionFailure("👉👉👉IconFont- 失败  👻")
            return UIFont.systemFont(ofSize: size)
        }
        CTFontManagerRegisterGraphicsFont(fontCG, nil)
        guard let font = UIFont(name: name, size: size) else{
            assertionFailure("👉👉👉IconFont-请确认\(name).ttf 和 font-family是否配置正确  👻")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
