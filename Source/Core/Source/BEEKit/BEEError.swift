//
//  BEEError.swift
//  BeeKit-Swift
//
//  Created by liuxc on 2021/1/28.
//

import Foundation

public struct BEEError : LocalizedError {

    public let domain: String
    public let code: Int
    public let userInfo: [String : Any]?

    /**
     Domain cannot be nil; code may be nil; dict may be nil if no userInfo desired.
    */
    public init(domain: String, code: Int = 0, userInfo dict: [String : Any]? = nil) {
        self.domain = domain
        self.code = code
        self.userInfo = dict
    }

    public var localizedDescription: String? {
        return domain
    }

    public var errorDescription: String? {
        return domain
    }
}
