import UIKit
import MBProgressHUD

public typealias HUDMode = MBProgressHUDMode
public typealias HUDAnimation = MBProgressHUDAnimation
public typealias HUDBackgroundStyle = MBProgressHUDBackgroundStyle
public typealias HUDCompletionBlock = MBProgressHUDCompletionBlock

public enum HUDStatus {
    case success
    case error
    case info
    case star
    case hollowStar
    case waitting
}

public struct HUDConfig {
        
    public static var imageSucess: UIImage? = HUD.bundleImage(by: "ic_tips_sucess")?.template
    public static var imageInfo: UIImage? = HUD.bundleImage(by: "ic_tips_info")?.template
    public static var imageError: UIImage? = HUD.bundleImage(by: "ic_tips_error")?.template
    
    public static var textColor: UIColor = UIColor.white
    public static var textFont: UIFont = .boldSystemFont(ofSize: 16)
    
    public static var contentColor: UIColor = UIColor.white
    public static var defaultDismissDuration: TimeInterval = 2.0
    public static var offSetY: CGFloat = 0
    public static var margin: CGFloat = 20
    public static var isSquare: Bool = true
    public static var minSize: CGSize = CGSize(width: 100, height: 100)
    public static var cornerRadius: CGFloat = 5.0
    
    public static var animationType: HUDAnimation = .zoom
    public static var backgroundStyle: HUDBackgroundStyle = .solidColor
    public static var backgroundColor: UIColor = UIColor.black

    public static var defaultWindow: UIWindow?
    public static var defaultLoadingText: String = "加载中..."
    public static var defaultToastInteraction: Bool = true
    public static var defaultHUDInteraction: Bool = false
}

open class HUD: MBProgressHUD {
    
    // MARK: - 在 window 上添加一个 HUD

    public static let shared = HUD(view: HUD.defaultWindow())
    
    // MARK: - 在 window 上添加一个 HUD
    
    @discardableResult
    public static func showStatus(status: HUDStatus,
                    text: String?,
                    duration: TimeInterval? = nil,
                    interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return HUD.defaultWindow().showStatus(status: status, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 window 上添加一个只显示文字的 HUD
    
    @discardableResult
    public static func showMessage(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultToastInteraction
    ) -> HUD? {
        return HUD.defaultWindow().showMessage(text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 window 上添加一个提示`信息`的 HUD
    
    @discardableResult
    public static func showInfoMsg(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return HUD.defaultWindow().showStatus(status: .info, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 window 上添加一个提示`失败`的 HUD
    
    @discardableResult
    public static func showFailure(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return HUD.defaultWindow().showStatus(status: .error, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 window 上添加一个提示`成功`的 HUD

    @discardableResult
    public static func showSuccess(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return HUD.defaultWindow().showStatus(status: .success, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 window 上添加一个提示`收藏成功`的 HUD
    
    @discardableResult
    public static func showAddFavorites(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return HUD.defaultWindow().showStatus(status: .star, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 window 上添加一个提示`取消收藏`的 HUD
    
    @discardableResult
    public static func showRemoveFavorites(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return HUD.defaultWindow().showStatus(status: .hollowStar, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 window 上添加一个提示`等待`的 HUD, 需要手动关闭

    @discardableResult
    public static func showLoading(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = false
    ) -> HUD? {
        return HUD.defaultWindow().showStatus(status: .waitting, text: text, duration: duration, interaction: interaction)
    }

    // MARK: - 手动隐藏 HUD
    
    public static func hide() {
        HUD.defaultWindow().hide()
    }
    
    public static func hideAllHUD() {
        HUD.hideAllHUD(for: HUD.defaultWindow())
    }
    
    public static func hideAllHUD(for view: UIView) {
        for subview in view.subviews {
            guard let hud = subview as? MBProgressHUD else {
                continue
            }
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true)
        }
    }

    // MARK: - private methods

    fileprivate static func defaultWindow() -> UIWindow {
        if let defaultWindow = HUDConfig.defaultWindow {
            return defaultWindow
        }
        guard let keywindow = UIApplication.shared.keyWindow else {
            assert(false, "application no key window")
            return UIWindow()
        }
        return keywindow
    }
    
    fileprivate static func bundleImage(by name: String) -> UIImage? {
        let resource_bundle = Bundle(path: Bundle(for: HUD.self).resourcePath ?? "")
        return UIImage(named: name, in: resource_bundle, compatibleWith: nil)
    }
}

public extension UIView {
    
    // MARK: - 在 view 上添加一个 HUD

    @discardableResult
    func showStatus(status: HUDStatus,
                    text: String?,
                    duration: TimeInterval? = nil,
                    interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        
        let hud = HUD.shared
        
        hud.removeFromSuperview()
        
        hud.frame = self.bounds
        
        hud.show(animated: true)
                                
        hud.label.text = text
                
        hud.removeFromSuperViewOnHide = true
        
        hud.label.font = HUDConfig.textFont
        
        hud.label.textColor = HUDConfig.textColor
                
        hud.label.numberOfLines = 0
        
        hud.contentColor = HUDConfig.contentColor
        
        hud.bezelView.style = HUDConfig.backgroundStyle
        
        hud.bezelView.backgroundColor = HUDConfig.backgroundColor
        
        hud.bezelView.cornerRadius = HUDConfig.cornerRadius
        
        hud.animationType = HUDConfig.animationType
        
        hud.isUserInteractionEnabled = !interaction
        
        hud.isSquare = HUDConfig.isSquare
        
        hud.margin = HUDConfig.margin
        
        hud.minSize = .zero
        
        addSubview(hud)
                
        switch status {
        case .success:
            
            hud.mode = .customView
            hud.hide(animated: true, afterDelay: duration ?? HUDConfig.defaultDismissDuration)
            let imageView = UIImageView(image: HUDConfig.imageSucess)
            imageView.tintColor = HUDConfig.contentColor
            hud.customView = imageView
            
        case .error:
            
            hud.mode = .customView
            hud.hide(animated: true, afterDelay: duration ?? HUDConfig.defaultDismissDuration)
            let imageView = UIImageView(image: HUDConfig.imageError)
            imageView.tintColor = HUDConfig.contentColor
            hud.customView = imageView
            
        case .info:
            
            hud.mode = .customView
            hud.hide(animated: true, afterDelay: duration ?? HUDConfig.defaultDismissDuration)
            let imageView = UIImageView(image: HUDConfig.imageInfo)
            imageView.tintColor = HUDConfig.contentColor
            hud.customView = imageView
            
        case .star:
            
            hud.mode = .customView
            hud.hide(animated: true, afterDelay: duration ?? HUDConfig.defaultDismissDuration)
            let imageView = UIImageView(image: HUDConfig.imageInfo)
            imageView.tintColor = HUDConfig.contentColor
            hud.customView = imageView
            
        case .hollowStar:
            
            hud.mode = .customView
            hud.hide(animated: true, afterDelay: duration ?? HUDConfig.defaultDismissDuration)
            let imageView = UIImageView(image: HUDConfig.imageInfo)
            imageView.tintColor = HUDConfig.contentColor
            hud.customView = imageView
            
        case .waitting:
            
            hud.mode = .indeterminate
            hud.isUserInteractionEnabled = false
        
        }
        
        return hud
    }
    
    // MARK: - 在 view 上添加一个只显示文字的 HUD
    
    @discardableResult
    func showMessage(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultToastInteraction
    ) -> HUD? {
        
        guard let text = text, !text.isEmpty else {
            return nil
        }
        
        let hud = HUD.showAdded(to: self, animated: true)
                
        hud.minSize = .zero
        
        hud.mode = .text
        
        hud.removeFromSuperViewOnHide = true
        
        hud.label.text = text
        
        hud.label.textColor = HUDConfig.textColor
        
        hud.label.font = HUDConfig.textFont
        
        hud.label.numberOfLines = 0
        
        hud.isUserInteractionEnabled = !interaction

        hud.contentColor = HUDConfig.contentColor
        
        hud.bezelView.style = HUDConfig.backgroundStyle
        
        hud.bezelView.backgroundColor = HUDConfig.backgroundColor
        
        hud.bezelView.cornerRadius = HUDConfig.cornerRadius
        
        hud.animationType = HUDConfig.animationType
                        
        hud.margin = HUDConfig.margin
        
        hud.isSquare = false
        
        hud.minSize = .zero
        
        hud.hide(animated: true, afterDelay: duration ?? HUDConfig.defaultDismissDuration)

        return hud
    }
    
    // MARK: - 在 view 上添加一个提示`信息`的 HUD
    
    @discardableResult
    func showInfoMsg(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return self.showStatus(status: .info, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 view 上添加一个提示`失败`的 HUD
    
    @discardableResult
    func showFailure(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return self.showStatus(status: .error, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 view 上添加一个提示`成功`的 HUD

    @discardableResult
    func showSuccess(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return self.showStatus(status: .success, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 view 上添加一个提示`收藏成功`的 HUD
    
    @discardableResult
    func showAddFavorites(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return self.showStatus(status: .star, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 view 上添加一个提示`取消收藏`的 HUD
    
    @discardableResult
    func showRemoveFavorites(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = HUDConfig.defaultHUDInteraction
    ) -> HUD? {
        return self.showStatus(status: .hollowStar, text: text, duration: duration, interaction: interaction)
    }
    
    // MARK: - 在 view 上添加一个提示`等待`的 HUD, 需要手动关闭

    @discardableResult
    func showLoading(
        text: String?,
        duration: TimeInterval? = nil,
        interaction: Bool = false
    ) -> HUD? {
        return self.showStatus(status: .waitting, text: text, duration: duration, interaction: interaction)
    }

    // MARK: - 手动隐藏 HUD
    
    func hide() {
        HUD.hide(for: self, animated: true)
    }

}
