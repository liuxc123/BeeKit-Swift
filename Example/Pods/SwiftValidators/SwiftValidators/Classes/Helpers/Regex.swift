//
//  Regex.swift
//  Nimble
//
//  Created by George Kaimakas on 02/07/2019.
//

import Foundation

enum Regex {
    static let EmailRegex: String = "[\\w._%+-|]+@[\\w0-9.-]+\\.[A-Za-z]{2,}"
    static let AlphaRegex: String = "[a-zA-Z]+"
    static let Base64Regex: String = "(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?"
    static let CreditCardRegex: String = "(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})"
    static let HexColorRegex: String = "#?([0-9A-F]{3}|[0-9A-F]{6})"
    static let HexadecimalRegex: String = "[0-9A-F]+"
    static let ASCIIRegex: String = "[\\x00-\\x7F]+"
    static let NumericRegex: String = "[-+]?[0-9]+"
    static let FloatRegex: String = "([\\+-]?\\d+)?\\.?\\d*([eE][\\+-]\\d+)?"
    static let IPRegex: [String:String] = [
        "4": "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d{1,2})",
        "6": "[0-9A-Fa-f]{1,4}"
    ]
    static let ISBNRegex: [String:String] = [
        "10": "(?:[0-9]{9}X|[0-9]{10})",
        "13": "(?:[0-9]{13})"
    ]
    static let AlphanumericRegex: String = "[\\d[A-Za-z]]+"
}
