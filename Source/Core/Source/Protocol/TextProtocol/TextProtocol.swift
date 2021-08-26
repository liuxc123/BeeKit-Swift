import Foundation
import UIKit

public protocol TextProtocol {
    /// T: String、NSAttributedString、UIColor、NSTextAlignment、UIFont、、
    func setText<T>(_ t: T?, _ state: UIControl.State?)
}

extension TextProtocol {
    /// T: String、NSAttributedString、UIColor、NSTextAlignment、UIFont、、
    public func setText<T>(_ t: T?, _ state: UIControl.State?){
        switch self {
        case let ui as UILabel:
            switch t {
            case let txt as String:
                ui.text = txt
            case let attributed as NSAttributedString:
                ui.attributedText = attributed
            case let color as UIColor:
                ui.textColor = color
            case let alignment as NSTextAlignment:
                ui.textAlignment = alignment
            case let font as UIFont:
                ui.font = font
            default:
                break
            }
        case let ui as UITextField:
            switch t {
            case let txt as String:
                ui.text = txt
            case let attributed as NSAttributedString:
                ui.attributedText = attributed
            case let color as UIColor:
                ui.textColor = color
            case let alignment as NSTextAlignment:
                ui.textAlignment = alignment
            case let font as UIFont:
                ui.font = font
            default:
                break
            }
        case let ui as UITextView:
            switch t {
            case let txt as String:
                ui.text = txt
            case let attributed as NSAttributedString:
                ui.attributedText = attributed
            case let color as UIColor:
                ui.textColor = color
            case let alignment as NSTextAlignment:
                ui.textAlignment = alignment
            case let font as UIFont:
                ui.font = font
            default:
                break
            }
        case let ui as UIButton:
            switch t {
            case let txt as String:
                ui.setTitle(txt, for: state ?? .normal)
            case let attributed as NSAttributedString:
                ui.setAttributedTitle(attributed, for: state ?? .normal)
            case let color as UIColor:
                ui.setTitleColor(color, for: state ?? .normal)
            case let font as UIFont:
                ui.titleLabel?.font = font
            default:
                break
            }
        default:
            break
        }
    }
}


public extension Bee where Base: TextProtocol {
    /// T: String、NSAttributedString、UIColor、NSTextAlignment、UIFont、、 state -> button use
    @discardableResult
    func text<T>(_ t: T?, _ state:UIControl.State? = .normal) -> Bee {
        base.setText(t, state)
        return self
    }
}

extension UILabel: TextProtocol {}
extension UIButton: TextProtocol {}
extension UITextField: TextProtocol {}
extension UITextView: TextProtocol {}

