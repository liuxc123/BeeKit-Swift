import UIKit

public class LimitSearchBar: UISearchBar,LimitInputProtocol {

    /// 调整至iOS11之前的风格(高度调整)
    public static var isEnbleOldStyleBefore11 = true

    public var preIR: IR? = nil

    /// 字数限制
    public var wordLimit: Int = LimitInput.wordLimit
    /// 文字超出字符限制执行
    public var overWordLimitEvent: ((String) -> ())? = LimitInput.overWordLimitEvent
    /// 表情限制
    public var emojiLimit: Bool = LimitInput.emojiLimit
    /// 表情限制回调
    public var emojiLimitEvent: ((String) -> ())? = nil
    /// 完成输入
    public var textDidChangeEvent: ((_ text: String)->())? = nil
    /// 文字替换
    public var replaces: [LimitInputReplace] = LimitInput.replaces
    /// 判断输入是否合法的
    public var matchs: [LimitInputMatch] = LimitInput.matchs
    /// 菜单禁用项
    public var disables: [LimitInputDisableState] = LimitInput.disables
    
    /// 调整至iOS11之前的风格(高度调整)
    public var isEnbleOldStyleBefore11 = LimitSearchBar.isEnbleOldStyleBefore11 {
        didSet{
            if #available(iOS 11,*), isEnbleOldStyleBefore11 {
                let reFont = searchField?.font?.withSize(14)
                placeholderFont = reFont
                searchField?.font = reFont
                self.barStyle = .default
            }
        }
    }

    /// 是否设置过iOS11之前的风格
    var isSetedOldStyleBefore11 = false

    /// 占位文字颜色
    public var placeholderColor: UIColor? {
        get{
            guard let attr = searchField?.attributedPlaceholder?.attributes(at: 0, effectiveRange: nil),
                  let color = attr[NSAttributedString.Key.foregroundColor] as? UIColor else{ return searchField?.textColor }
            return color
        }
        set {
            guard let placeholder = self.placeholder, let color = newValue else { return }
            if var attr = searchField?.attributedPlaceholder?.attributes(at: 0, effectiveRange: nil) {
                attr[NSAttributedString.Key.foregroundColor] = newValue
                searchField?.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attr)
                return
            }

            let attr = [NSAttributedString.Key.foregroundColor: color]
            searchField?.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attr)
        }
    }

    /// 占位文字字体
    public var placeholderFont: UIFont? {
        get{
            guard let attr = searchField?.attributedPlaceholder?.attributes(at: 0, effectiveRange: nil),
                  let ft = attr[.font] as? UIFont else{ return searchField?.font }
            return ft
        }
        set {
            guard let placeholder = self.placeholder, let font = newValue else { return }
            if var attr = searchField?.attributedPlaceholder?.attributes(at: 0, effectiveRange: nil) {
                attr[NSAttributedString.Key.font] = newValue
                searchField?.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attr)
                return
            }
            let attr = [NSAttributedString.Key.font: font]
            searchField?.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attr)
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        guard #available(iOS 11,*), isEnbleOldStyleBefore11 else { return }
        guard let heightConstraint = self.constraints.first, let searchField = searchField else { return }
        heightConstraint.constant = isEnbleOldStyleBefore11 ? 44 : 56
        self.layoutIfNeeded()

        if isSetedOldStyleBefore11 { return }
        searchField.bounds.size.height = isEnbleOldStyleBefore11 ? 28 : 32
        searchField.frame.origin.y = (self.bounds.height - searchField.bounds.height) * 0.5
        isSetedOldStyleBefore11 = true
    }

    /// 输入控件
    public lazy var searchField: UITextField? = {
        if #available(iOS 13.0, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }()

    private var inputHelp: LimitSearchBarExecutor?

    open var limitDelegate: UISearchBarDelegate? {
        get { return inputHelp }
        set { inputHelp = LimitSearchBarExecutor(delegate: newValue)
            self.delegate = inputHelp
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        limitDelegate = nil
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        limitDelegate = nil
    }

    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return canPerformAction(self, text: text ?? "", action: action) ? super.canPerformAction(action, withSender: sender) : false
    }

}
