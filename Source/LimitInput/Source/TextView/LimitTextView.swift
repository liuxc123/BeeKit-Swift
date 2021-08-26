import UIKit

public class LimitTextView: UITextView,LimitInputProtocol {

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

    /// 占位文本控件
    public lazy var placeholderLabel: UILabel = {
        let item = UILabel()
        item.numberOfLines = 0
        item.font = UIFont.systemFont(ofSize: 15)
        item.textColor = UIColor.gray.withAlphaComponent(0.7)
        self.addSubview(item)
        self.setValue(item, forKey: "_placeholderLabel")
        return item
    }()

    /// 占位颜色
    open var placeholderColor: UIColor{
        set{ placeholderLabel.textColor = newValue }
        get{ return placeholderLabel.textColor }
    }

    /// 占位富文本
    open var attributedPlaceholder: NSAttributedString? {
        set{ placeholderLabel.attributedText = newValue }
        get{ return placeholderLabel.attributedText }
    }

    /// 占位文本
    open var placeholder: String? {
        set{ placeholderLabel.text = newValue }
        get{ return placeholderLabel.text }
    }

    /// 更新内间距
    open var inset: UIEdgeInsets = .zero {
        didSet {
            contentInset = .zero
            scrollIndicatorInsets = .zero
            contentOffset = .zero
            textContainerInset = inset
            textContainer.lineFragmentPadding = 0
        }
    }

    private var inputHelp: LimitTextViewExecutor?

    open var limitDelegate: UITextViewDelegate? {
        get { return inputHelp }
        set { inputHelp = LimitTextViewExecutor(delegate: newValue)
            self.delegate = inputHelp
        }
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        buildConfig()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        buildConfig()
    }

    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return canPerformAction(self, text: text, action: action) ? super.canPerformAction(action, withSender: sender) : false
    }

    //MARK: - Deinitialized
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - Config
extension LimitTextView{

    func buildConfig() {
        limitDelegate = nil
        inset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        buildNotifications()
    }

    fileprivate func buildNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textView(changed:)),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
}

extension LimitTextView {
    @objc private func textView(changed not: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let input = not.object as? LimitTextView, self === input else { return }
            guard let ir = self.textDidChange(input: input, text: input.text) else {
                input.textDidChangeEvent?(input.text ?? "")
                return
            }
            input.text = ir.text
            (input as UITextInput).selectedRange = ir.range
            input.textDidChangeEvent?(ir.text)
        }
    }
}

