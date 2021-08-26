//
//  AnyOptional.swift
//  BeeKit-Swift
//
//  Created by liuxc on 2021/1/28.
//

import Foundation

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
