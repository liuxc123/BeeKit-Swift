//
//  UIButton+Extensions.swift
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

public enum UIButtonImagePosition: Int {
    case left   = 0
    case right  = 1
    case top    = 2
    case bottom = 3
}

// MARK: - UIButton extension

/// This extesion adds some useful functions to UIButton.
public extension UIButton {
    // MARK: - Functions
    
    /// Create an UIButton in a frame with a title, a background image and highlighted background image.
    ///
    /// - Paramters:
    ///   - frame: Button frame.
    ///   - title: Button title.
    ///   - backgroundImage: Button background image.
    ///   - highlightedBackgroundImage: Button highlighted background image.
    convenience init(frame: CGRect, title: String, backgroundImage: UIImage? = nil, highlightedBackgroundImage: UIImage? = nil) {
        self.init(frame: frame)
        self.frame = frame
        setTitle(title, for: UIControl.State.normal)
        setBackgroundImage(backgroundImage, for: UIControl.State.normal)
        setBackgroundImage(highlightedBackgroundImage, for: UIControl.State.highlighted)
    }
    
    /// Create an UIButton in a frame with a title and a color.
    ///
    /// - Parameters:
    ///   - frame: Button frame.
    ///   - title: Button title.
    ///   - color: Button color, the highlighted color will be automatically created.
    convenience init(frame: CGRect, title: String, color: UIColor) {
        guard let components: UnsafePointer<CGFloat> = color.cgColor.__unsafeComponents else {
            self.init(frame: frame, title: title)
            return
        }
        
        self.init(frame: frame, title: title, backgroundImage: UIImage(color: color), highlightedBackgroundImage: UIImage(color: UIColor(red: components[0] - 0.1, green: components[1] - 0.1, blue: components[2] - 0.1, alpha: 1)))
    }
    
    /// Create an UIButton in a frame with a title, a color and highlighted color.
    ///
    /// - Parameters:
    ///   - frame: Button frame.
    ///   - title: Button title.
    ///   - color: Button color.
    ///   - highlightedColor: Button highlighted color.
    convenience init(frame: CGRect, title: String, color: UIColor, highlightedColor: UIColor) {
        self.init(frame: frame, title: title, backgroundImage: UIImage(color: color), highlightedBackgroundImage: UIImage(color: highlightedColor))
    }
    
    /// Create an UIButton in a frame with an image
    ///
    /// - Parameters:
    ///   - frame: Button frame
    ///   - image: Button image
    ///   - highlightedImage: Button highlighted image
    convenience init(frame: CGRect, image: UIImage, highlightedImage: UIImage? = nil) {
        self.init(frame: frame)
        self.frame = frame
        setImage(image, for: UIControl.State.normal)
        setImage(highlightedImage, for: UIControl.State.highlighted)
    }
    
    /// Set the title color.
    ///
    /// - Parameter color: Font color, the highlighted color will be automatically created.
    func setTitleColor(_ color: UIColor) {
        setTitleColor(color, highlightedColor: color.withAlphaComponent(0.4))
    }
    
    /// Set the title color and highlighted color
    ///
    /// - Parameters:
    ///   - color: Button color
    ///   - highlightedColor: Button highlighted color
    func setTitleColor(_ color: UIColor, highlightedColor: UIColor) {
        setTitleColor(color, for: UIControl.State.normal)
        setTitleColor(highlightedColor, for: UIControl.State.highlighted)
    }

    /// Set the image position
    ///
    /// - Parameters:
    ///   - position: Button image position
    ///   - spacing: Button image and title space
    func setImagePosition(position: UIButtonImagePosition, spacing: CGFloat) {

        self.setTitle(self.currentTitle, for: .normal)
        self.setImage(self.currentImage, for: .normal)

        let imageWidth:CGFloat = (self.imageView?.image?.size.width)!
        let imageHeight:CGFloat = (self.imageView?.image?.size.height)!

        let titleStr:NSString = (self.titleLabel?.text)! as NSString
        let font:UIFont = self.titleLabel!.font
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = titleStr.boundingRect(with: CGSize(width: LONG_MAX, height: LONG_MAX), options: option, attributes: attributes , context: nil)

        let labelWidth:CGFloat = rect.width
        let labelHeight:CGFloat = rect.height

        let imageOffsetX:CGFloat = (imageWidth + labelWidth) / 2.0 - imageWidth/2.0
        let imageOffsetY:CGFloat = imageHeight / 2.0 + spacing / 2.0
        let labelOffsetX:CGFloat = (imageWidth + labelWidth / 2.0) - (imageWidth + labelWidth)/2.0
        let labelOffsetY:CGFloat = labelHeight / 2.0 + spacing / 2.0

        let tempWidth:CGFloat = max(labelWidth, imageWidth)
        let changedWidth:CGFloat = labelWidth + imageWidth - tempWidth
        let tempHeight:CGFloat = max(labelHeight, imageHeight)
        let changedHeight:CGFloat = labelHeight + imageHeight + spacing - tempHeight

        switch position {
        case .left:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2.0, bottom: 0, right: spacing/2.0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2.0, bottom: 0, right: -spacing/2.0)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2.0, bottom: 0, right: spacing/2.0)
            break
        case .right:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + spacing/2.0, bottom: 0, right: -(labelWidth + spacing / 2.0))
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageWidth + spacing/2), bottom: 0, right: imageWidth + spacing/2)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2.0, bottom: 0, right: spacing/2.0)
            break
        case .top:
            self.imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: -changedWidth/2, bottom: changedHeight-imageOffsetY, right: -changedWidth/2)
            break
        case .bottom:
            self.imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX, bottom: labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: changedHeight-imageOffsetY, left: -changedWidth/2, bottom: imageOffsetY, right: -changedWidth/2)
            break
        }
    }

    /// Show the image loading
    func loading(bgViewColor: UIColor = .clear,
                 bgViewFrame: CGRect = .zero,
                 style: UIActivityIndicatorView.Style = .gray,
                 activityColor: UIColor = .clear) {
        isEnabled = false
        let activity = UIActivityIndicatorView(style: style)
        activity.startAnimating()
        let view = UIView()
        view.tag = -8668
        if bgViewFrame == .zero {
            superview?.layoutIfNeeded()
            view.frame = bounds
        }else{
            view.frame = bgViewFrame
        }
        if bgViewColor == .clear {
            view.backgroundColor = bgViewColor
        }else{
            view.backgroundColor = backgroundColor
        }
        if activityColor != .clear {
            activity.color = activityColor
        }
        activity.frame = view.bounds

        addSubview(view)
        view.addSubview(activity)
    }

    /// Show the image custom loading
    func loading(_ custom:(()->Void)) {
        isEnabled = false
        custom()
    }

    /// Hidden the image custom loading
    func loadingHidden(_ tag: Int = -8668) {
        viewWithTag(tag)?.removeFromSuperview()
        isEnabled = true
    }
}
