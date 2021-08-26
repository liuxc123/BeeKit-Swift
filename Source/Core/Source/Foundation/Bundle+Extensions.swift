//
//  Bundle+Extensions.swift
//  BeeKit
//
//  Created by liuxc on 2021/1/14.
//

import Foundation
import UIKit

public extension Bundle {
    //MARK:--- Pod Bundle 检索 ----------
    /// - from:bundle.url(forResource ‘(pod s.resource_bundles -> key)’
    static func bundle(_ forClass: AnyClass, _ from: String? = nil) -> Bundle? {
        let bundle = Bundle(for: forClass)
        guard let bundleURL = bundle.url(forResource: from, withExtension: "bundle") else {
//            assertionFailure("👉👉👉\(from ?? "") - 无法找到 Bundle  👻")
            return nil
        }
        return Bundle(url: bundleURL)
    }
}
