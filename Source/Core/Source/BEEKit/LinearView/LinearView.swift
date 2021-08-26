import UIKit

public class LinearView: UIView {
    
    typealias Item = LinearLayout.Item
    typealias Space = LinearLayout.Space
    
    public private(set) var layout: LinearLayout = .init() {
        didSet { update(layout) }
    }
    
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayout()
        
        update(layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupLayout()
    }
    
    private func setup() {
        backgroundColor = .clear
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        addSubview(stackView)
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            .init(
                item: self,
                attribute: .top,
                relatedBy: .equal,
                toItem: stackView,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ),
            .init(
                item: self,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: stackView,
                attribute: .bottom,
                multiplier: 1,
                constant: 0
            ),
            .init(
                item: self,
                attribute: .leading,
                relatedBy: .equal,
                toItem: stackView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            ),
            .init(
                item: self,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: stackView,
                attribute: .trailing,
                multiplier: 1,
                constant: 0
            )
        ])
        layoutIfNeeded()
    }
    
    private func update(_ layout: LinearLayout) {
        layout.spacingChanged = { [weak self] space in
            self?.stackView.arrangedSubviews.forEach {
                guard let view = $0 as? SpacingView else { return }
                guard view.space.identifier == space.identifier else { return }
                view.set(space.constant)
            }
        }
        
        layout.completed = { [weak self] in
            self?.update(layout)
        }
        
        // 移除原有子视图
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        stackView.axis = layout.axis
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        var current: WrapperView?
        
        // 设置子视图
        for (index, item) in layout.items.enumerated() {
                        
            let wrapper = WrapperView(item())
            
            wrapper.item.view.translatesAutoresizingMaskIntoConstraints = false
            wrapper.translatesAutoresizingMaskIntoConstraints = false
            
            switch layout.axis {
            case .vertical:
                switch wrapper.item.layout {
                case let .constant(value, alignment):
                    let constraint = NSLayoutConstraint(
                        item: wrapper.item.view,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .width,
                        multiplier: 1,
                        constant: value
                    )
                    constraint.priority = .init(rawValue: 999)
                    constraint.identifier = "LinearView"
                    wrapper.item.view.addConstraint(constraint)
                    
                    switch alignment.value {
                    case 0:
                        wrapper.addConstraint(
                            .init(
                                item: wrapper,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: wrapper.item.view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: -(alignment.offset ?? 0)
                            )
                        )
                        
                    case 1:
                        wrapper.addConstraint(
                            .init(
                                item: wrapper,
                                attribute: .leading,
                                relatedBy: .equal,
                                toItem: wrapper.item.view,
                                attribute: .leading,
                                multiplier: 1,
                                constant: -(alignment.offset ?? 0)
                            )
                        )
                        
                    case 2:
                        wrapper.addConstraint(
                            .init(
                                item: wrapper,
                                attribute: .trailing,
                                relatedBy: .equal,
                                toItem: wrapper.item.view,
                                attribute: .trailing,
                                multiplier: 1,
                                constant: alignment.offset ?? 0
                            )
                        )
                        
                    default:
                        continue
                    }
                    
                case let .automatic(leading, trailing):
                    wrapper.addConstraints([
                        .init(
                            item: wrapper,
                            attribute: .leading,
                            relatedBy: .equal,
                            toItem: wrapper.item.view,
                            attribute: .leading,
                            multiplier: 1,
                            constant: -leading
                        ),
                        .init(
                            item: wrapper,
                            attribute: .trailing,
                            relatedBy: .equal,
                            toItem: wrapper.item.view,
                            attribute: .trailing,
                            multiplier: 1,
                            constant: trailing
                        )
                    ])
                }
                
                wrapper.addConstraints([
                    .init(
                        item: wrapper,
                        attribute: .top,
                        relatedBy: .equal,
                        toItem: wrapper.item.view,
                        attribute: .top,
                        multiplier: 1,
                        constant: 0
                    ),
                    .init(
                        item: wrapper,
                        attribute: .bottom,
                        relatedBy: .equal,
                        toItem: wrapper.item.view,
                        attribute: .bottom,
                        multiplier: 1,
                        constant: 0
                    )
                ])
                
            case .horizontal:
                switch wrapper.item.layout {
                case let .constant(value, alignment):
                    let constraint = NSLayoutConstraint(
                        item: wrapper.item.view,
                        attribute: .height,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .height,
                        multiplier: 1,
                        constant: value
                    )
                    constraint.priority = .init(rawValue: 999)
                    constraint.identifier = "LinearView"
                    wrapper.item.view.addConstraint(constraint)
                    
                    switch alignment.value {
                    case 0:
                        wrapper.addConstraint(
                            .init(
                                item: wrapper,
                                attribute: .centerY,
                                relatedBy: .equal,
                                toItem: wrapper.item.view,
                                attribute: .centerY,
                                multiplier: 1,
                                constant: -(alignment.offset ?? 0)
                            )
                        )
                        
                    case 1:
                        wrapper.addConstraint(
                            .init(
                                item: wrapper,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: wrapper.item.view,
                                attribute: .top,
                                multiplier: 1,
                                constant: -(alignment.offset ?? 0)
                            )
                        )
                        
                    case 2:
                        wrapper.addConstraint(
                            .init(
                                item: wrapper,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: wrapper.item.view,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: alignment.offset ?? 0
                            )
                        )
                        
                    default:
                        continue
                    }
                    
                case let .automatic(leading, trailing):
                    wrapper.addConstraints([
                        .init(
                            item: wrapper,
                            attribute: .top,
                            relatedBy: .equal,
                            toItem: wrapper.item.view,
                            attribute: .top,
                            multiplier: 1,
                            constant: -leading
                        ),
                        .init(
                            item: wrapper,
                            attribute: .bottom,
                            relatedBy: .equal,
                            toItem: wrapper.item.view,
                            attribute: .bottom,
                            multiplier: 1,
                            constant: trailing
                        )
                    ])
                }
                
                wrapper.addConstraints([
                    .init(
                        item: wrapper,
                        attribute: .leading,
                        relatedBy: .equal,
                        toItem: wrapper.item.view,
                        attribute: .leading,
                        multiplier: 1,
                        constant: 0
                    ),
                    .init(
                        item: wrapper,
                        attribute: .trailing,
                        relatedBy: .equal,
                        toItem: wrapper.item.view,
                        attribute: .trailing,
                        multiplier: 1,
                        constant: 0
                    )
                ])
                
            @unknown default:
                continue
            }
            
            // 添加间距视图
            spacing(layout.spaces[index], last: current, next: wrapper)
            // 添加包装视图
            stackView.addArrangedSubview(wrapper)
            // 记录当前包装视图
            current = wrapper
        }
        
        // 添加结尾间距视图
        spacing(layout.spaces[layout.items.count], last: current, next: .none)
    }
    
    private func spacing(_ value: [Space]?, last: WrapperView?, next: WrapperView?) {
        guard let array = value else {
            return
        }
        
        for space in array {
            let view = SpacingView(space, axis: layout.axis)
            stackView.addArrangedSubview(view)
            
            // 间距模式
            switch space.mode {
            case .follow:
                // 添加需要跟随的视图
                view.add(follow: last)
                view.add(follow: next)
                
            default:
                break
            }
        }
    }
}

extension LinearView {
    
    /// Layout configuration
    /// - Parameter axis: A stack with a horizontal axis is a row of arrangedSubviews, and a stack with a vertical axis is a column of arrangedSubviews.
    /// - Returns: LinearLayout
    public func layout(_ axis: NSLayoutConstraint.Axis = .vertical) -> LinearLayout {
        layout = .init(axis)
        return layout
    }
}

fileprivate class WrapperView: UIView {
    
    typealias Item = LinearLayout.Item
    
    let item: Item
    
    private var observation: NSKeyValueObservation?
    
    init(_ item: Item) {
        self.item = item
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubview(item.view)
        
        observation = item.view.observe(\.isHidden) { [weak self] (object, changed) in
            self?.isHidden = object.isHidden
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class SpacingView: UIView {
    
    typealias Space = LinearLayout.Space
    
    private(set) var space: Space
    private weak var constraint: NSLayoutConstraint?
    private var observations: [NSKeyValueObservation] = []
    
    init(_ space: Space, axis: NSLayoutConstraint.Axis) {
        self.space = space
        super.init(frame: .zero)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        switch axis {
        case .vertical:
            let constraint = NSLayoutConstraint(
                item: self,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .height,
                multiplier: 1,
                constant: space.constant
            )
            addConstraint(constraint)
            self.constraint = constraint
            
        case .horizontal:
            let constraint = NSLayoutConstraint(
                item: self,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .width,
                multiplier: 1,
                constant: space.constant
            )
            addConstraint(constraint)
            self.constraint = constraint
            
        @unknown default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ constant: CGFloat) {
        space.constant = constant
        constraint?.constant = constant
    }
    
    func add(follow view: UIView?) {
        guard let view = view else {
            return
        }
        
        observations.append(
            view.observe(\.isHidden) { [weak self] (object, changed) in
                self?.isHidden = object.isHidden
            }
        )
    }
}
