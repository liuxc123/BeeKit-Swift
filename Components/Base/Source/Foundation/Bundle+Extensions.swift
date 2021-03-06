//
//  Bundle+Extensions.swift
//  BeeKit
//
//  Created by liuxc on 2021/1/14.
//

import Foundation
import UIKit

public extension Bundle {
    //MARK:--- Pod Bundle ζ£η΄’ ----------
    /// - from:bundle.url(forResource β(pod s.resource_bundles -> key)β
    static func bundle(_ forClass: AnyClass, _ from: String? = nil) -> Bundle? {
        let bundle = Bundle(for: forClass)
        guard let bundleURL = bundle.url(forResource: from, withExtension: "bundle") else {
//            assertionFailure("πππ\(from ?? "") - ζ ζ³ζΎε° Bundle  π»")
            return nil
        }
        return Bundle(url: bundleURL)
    }
}
