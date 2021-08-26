/***** 模块文档 *****
 * UserDefaults 管理协议 遵循此协议，更方便管理
 
 * 示例
enum UserDefaulsUser:String {
    case token = "token"
}
extension UserDefaulsUser:UserDefaultsProtocol {
    var name: String {
        return "user."+self.rawValue
    }
}
UserDefaulsUser.token.save("123")
*/

import Foundation

public protocol UserDefaultsProtocol {
    var name: String { get }
    var value:Any? {get}
    var object:Any? {get}
    var string:String? {get}
    var bool:Bool {get}
    var dictionary:[String:Any]? {get}
    var array:[Any]? {get}
    func save(_ value:Any?)
    func remove()
}

extension UserDefaultsProtocol {
    public var value:Any? {
        return UserDefaults.standard.object(forKey: name)
    }
    public var object:Any? {
        return UserDefaults.standard.object(forKey: name)
    }
    public var string:String? {
        return UserDefaults.standard.string(forKey: name)
    }
    public var bool:Bool {
        return UserDefaults.standard.bool(forKey: name)
    }
    public var dictionary:[String:Any]? {
        return UserDefaults.standard.dictionary(forKey: name)
    }
    public var array:[Any]? {
        return UserDefaults.standard.array(forKey: name)
    }

    public func save(_ value:Any?) {
        UserDefaults.standard.set(value, forKey: name)
        UserDefaults.standard.synchronize()
    }
    public func remove() {
        UserDefaults.standard.removeObject(forKey: name)
    }
}

extension UserDefaults {
    public static func value(_ key:String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    public static func bool(_ key:String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    public static func string(_ key:String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    public static func stringArray(_ key:String) -> [String]? {
        return UserDefaults.standard.stringArray(forKey: key)
    }
    public static func array(_ key:String) -> [Any]? {
        return UserDefaults.standard.array(forKey: key)
    }
    public static func dictionary(_ key:String) -> [String : Any]? {
        return UserDefaults.standard.dictionary(forKey: key)
    }
    public static func save(_ value: Any?, key:String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    public static func remove(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
