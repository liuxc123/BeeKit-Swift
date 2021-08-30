import UIKit

@IBDesignable
open class LimitTextField: UITextField,LimitInputProtocol {

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

    private var inputHelp: LimitTextFieldExecutor?

    open var limitDelegate: UITextFieldDelegate? {
        get { return inputHelp }
        set { inputHelp = LimitTextFieldExecutor(delegate: newValue)
            self.delegate = inputHelp
        }
    }

    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return canPerformAction(self, text: text ?? "", action: action) ? super.canPerformAction(action, withSender: sender) : false
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildConfig()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        buildConfig()
    }

    /// MARK: - Deinitialized
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

/// MARK: - Config
extension LimitTextField{

    func buildConfig() {
        limitDelegate = nil
        buildNotifications()
    }

    fileprivate func buildNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textField(changed:)),
                                               name:  UITextField.textDidChangeNotification,
                                               object: nil)
    }

}

extension LimitTextField {

    @objc private func textField(changed not: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let input = not.object as? LimitTextField, self === input else { return }
            guard let ir = self.textDidChange(input: input, text: input.text ?? "") else {
                input.textDidChangeEvent?(input.text ?? "")
                return
            }
            input.text = ir.text
            (input as UITextInput).selectedRange = ir.range
            input.textDidChangeEvent?(ir.text)
        }
    }
}





