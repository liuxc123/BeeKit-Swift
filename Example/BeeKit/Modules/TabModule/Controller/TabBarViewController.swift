//
//  TabBarViewController.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/14.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import BeeKit_Swift

final class TabBarViewController: TabBarController {

    enum TabBarMode: Int {
        case beekit     = 0
        case foundation = 1
        case uikit      = 2

        var selectImage: UIImage? {
            switch self {
            case .beekit: return R.image.beeKitIcon()
            case .foundation: return R.image.foundationIcon()
            case .uikit: return R.image.uiKitIcon()
            }
        }

        var unselectImage: UIImage? {
            switch self {
            case .beekit: return R.image.beeKitIcon()
            case .foundation: return R.image.foundationIcon()
            case .uikit: return R.image.uiKitIcon()
            }
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupTheme()
    }

    private func setupControllers() {
        var viewControllers = [UIViewController]()

        let tabbarMode: [TabBarMode] = [.beekit, .foundation, .uikit]
        for mode in tabbarMode {

            var vc: UIViewController!
            switch mode {
            case .beekit:
                vc = BEEKitListViewController()
                vc.hidesBottomBarWhenPushed = false
                vc.tabBarItem = UITabBarItem(title: "BeeKit", image: mode.unselectImage?.template, selectedImage: mode.selectImage?.template)
                vc.tabBarItem.tag = mode.rawValue
            case .foundation:
                vc = FoundationListViewController()
                vc.hidesBottomBarWhenPushed = false
                vc.tabBarItem = UITabBarItem(title: "Foundation", image: mode.unselectImage?.template, selectedImage: mode.selectImage?.template)
                vc.tabBarItem.tag = mode.rawValue
            case .uikit:
                vc = UIKitListViewController()
                vc.hidesBottomBarWhenPushed = false
                vc.tabBarItem = UITabBarItem(title: "UIKit", image: mode.unselectImage?.template, selectedImage: mode.selectImage?.template)
                vc.tabBarItem.tag = mode.rawValue
            }

            let nav = NavgationController(rootViewController: vc)
            AppThemeService.themeNavigationBar(nav: nav)
            viewControllers.append(nav)
        }

        self.viewControllers = viewControllers
    }

    func setupTheme() {
        AppThemeService.themeTabBar(vc: self)
    }
}

extension TabBarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

}
