//
//  StatePlaceholderView.swift
//  ProtocolTool
//
//  Created by liuxc on 2019/8/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit

public protocol StatefulPlaceholderView {

    func placeholderViewInsets() -> UIEdgeInsets
}

extension StatefulPlaceholderView {

    public func placeholderViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
