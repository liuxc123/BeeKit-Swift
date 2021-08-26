//
//  UIScreen+Extensions.swift
//  BeeKit-Swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2019 Fabrizio Brancati.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit

// MARK: - UIScreen extension

/// This extesion adds some useful functions to UIScreen.
public extension UIScreen {
    // MARK: - Variables
    
    /// Get the screen width.
    static var screenWidth: CGFloat {
        UIScreen.fixedScreenSize().width
    }
    
    /// Get the screen height.
    static var screenHeight: CGFloat {
        UIScreen.fixedScreenSize().height
    }
    
    /// Get the maximum screen length.
    static var maxScreenLength: CGFloat {
        max(screenWidth, screenHeight)
    }

    /// Get the minimum screen length.
    static var minScreenLength: CGFloat {
        min(screenWidth, screenHeight)
    }
    /// Get the one pixle screen.
    static var onePixle: CGFloat {
        return CGFloat(1)/UIScreen.main.scale
    }

    /// Get the safeAreaInsets.
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }

    /// Get the statusBar.
    static var statusBar: CGSize {
        return CGSize(width: screenWidth, height: safeAreaInsets.top)
    }

    /// Get the navBar.
    static var navBar: CGSize {
        return CGSize(width: screenWidth, height: 44)
    }

    /// Get the  topBar with statusBar + navBar.
    static var topBar: CGSize {
        return CGSize.init(width: screenWidth, height: safeAreaInsets.top + navBar.height)
    }

    /// Get the tabBar.
    static var tabBar: CGSize {
        return CGSize.init(width: screenWidth, height: 49)
    }

    /// Get the tabBar + safeAreaInsets.bottom
    static var bottomBar: CGSize {
        return CGSize.init(width: screenWidth, height: safeAreaInsets.bottom + tabBar.height)
    }
    
    // MARK: - Functions
    
    /// Check if current device has a Retina display.
    ///
    /// - Returns: Returns true if it has a Retina display, otherwise false.
    static func isRetina() -> Bool {
        UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) && UIScreen.main.scale == 2.0
    }
    
    /// Check if current device has a Retina HD display.
    ///
    /// - Returns: Returns true if it has a Retina HD display, otherwise false.
    static func isRetinaHD() -> Bool {
        UIScreen.main.responds(to: #selector(UIScreen.displayLink(withTarget:selector:))) && UIScreen.main.scale == 3.0
    }
    
    /// Returns fixed screen size, based on device orientation.
    ///
    /// - Returns: Returns a GCSize with the fixed screen size.
    static func fixedScreenSize() -> CGSize {
        UIScreen.main.bounds.size
    }

    /// 获取某个视图控制器的布局安全距离
    /// - Parameter viewController: 视图控制器
    static func safeAreaInsets(for viewController: UIViewController) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return viewController.view.safeAreaInsets
        } else {
            return safeAreaInsets
        }
    }

    /// 获取某个视图控制器的顶部栏（状态栏+导航栏）的高度
    /// - Parameter viewController: 视图控制器
    func topBarHeight(for viewController: UIViewController?) -> CGFloat {
        if let nav = viewController as? UINavigationController {
            var h = nav.navigationBar.frame.size.height
            h += UIScreen.safeAreaInsets(for: nav).top
            return h
        } else if let vc = viewController {
            return UIScreen.safeAreaInsets(for: vc).top + (vc.navigationController?.navigationBar.frame.size.height ?? UIScreen.navBar.height)
        } else {
            return 0
        }
    }

    /// 获取某个视图控制器的底部栏（Tabbar和底部安全区域）高度
    /// - Parameter viewController: 视图控制器
    func bottomBarHeight(for viewController: UIViewController) -> CGFloat {
        return UIScreen.safeAreaInsets(for: viewController).bottom + (viewController.tabBarController?.tabBar.frame.height ?? UIScreen.tabBar.height)
    }
}
