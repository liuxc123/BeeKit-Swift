import Foundation

// MARK: - Global variables

/// NSLocalizedString without comment parameter.
///
/// - Parameter key: The key of the localized string.
/// - Returns: Returns a localized string.
public func NSLocalizedString(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}

// MARK: - BEEApp struct

/// This class adds some useful functions for the App.
public enum BEEApp {
    // MARK: - Variables

    /// Used to store the BEEHasBeenOpened in defaults.
    internal static let BEEAppHasBeenOpened = "BEEAppHasBeenOpened"

    /// Use this var to set you DEBUG or not builds.
    /// More info on how to use it [here](http://stackoverflow.com/questions/26890537/disabling-nslog-for-production-in-swift-project/26891797#26891797).
    public static var isDebug = false

    // MARK: - Functions

    /// Executes a block only if in DEBUG mode.
    ///
    /// - Parameter block: The block to be executed.
    public static func debug(_ block: () -> Void) {
        if isDebug {
            block()
        }
    }

    /// Executes a block only if NOT in DEBUG mode.
    ///
    /// - Parameter block: The block to be executed.
    public static func release(_ block: () -> Void) {
        if !isDebug {
            block()
        }
    }

    /// If version is set returns if is first start for that version,
    /// otherwise returns if is first start of the App.
    ///
    /// - Parameter version: Version to be checked, you can use the variable `BEEApp.version` to pass the current App version.
    /// - Returns: Returns if is first start of the App or for custom version.
    public static func isFirstStart(version: String = "") -> Bool {
        let key: String = BEEAppHasBeenOpened + version

        let defaults = UserDefaults.standard
        let hasBeenOpened: Bool = defaults.bool(forKey: key)

        return !hasBeenOpened
    }

    /// Executes a block on first start of the App, if version is set it will be for given version.
    ///
    /// Remember to execute UI instuctions on main thread.
    ///
    /// - Parameters:
    ///   - version: Version to be checked, you can use the variable `BEEApp.version` to pass the current App version.
    ///   - block: The block to execute, returns isFirstStart.
    public static func onFirstStart(version: String = "", block: (_ isFirstStart: Bool) -> Void) {
        let key: String = BEEAppHasBeenOpened + version

        let defaults = UserDefaults.standard
        let hasBeenOpened: Bool = defaults.bool(forKey: key)
        if hasBeenOpened != true {
            defaults.set(true, forKey: key)
        }

        block(!hasBeenOpened)
    }

    /// Reset the App like has never been started.
    ///
    /// - Parameter version: Version to be checked, you can use the variable `BEEApp.version` to pass the current App version.
    public static func resetFirstStart(version: String = "") {
        let key: String = BEEAppHasBeenOpened + version

        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }

    /// Set the App setting for a given object and key. The file will be saved in the Library directory.
    ///
    /// - Parameters:
    ///   - object: Object to set.
    ///   - objectKey: Key to set the object.
    /// - Returns: Returns true if the operation was successful, otherwise false.
    @discardableResult
    public static func setAppSetting(object: Any, forKey objectKey: String) -> Bool {
        FileManager.default.setSettings(filename: BEEApp.name, object: object, forKey: objectKey)
    }

    /// Get the App setting for a given key.
    ///
    /// - Parameter objectKey: Key to get the object.
    /// - Returns: Returns the object for the given key.
    public static func getAppSetting(objectKey: String) -> Any? {
        FileManager.default.getSettings(filename: BEEApp.name, forKey: objectKey)
    }

    /// Check if the app has been installed from TestFlight.
    ///
    /// - Returns: Returns `true` if the app has been installed via TestFlight, otherwise `false`.
    public static func isFromTestFlight() -> Bool {
        guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL else {
            return false
        }

        return appStoreReceiptURL.lastPathComponent == "sandboxReceipt"
    }
}

// MARK: - BEEApp extension

/// Extends BEEApp with project infos.
public extension BEEApp {
    // MARK: - Variables

    /// Return the App name.
    static var name: String = {
        BEEApp.stringFromInfoDictionary(forKey: "CFBundleDisplayName")
    }()

    /// Returns the App version.
    static var version: String = {
        BEEApp.stringFromInfoDictionary(forKey: "CFBundleShortVersionString")
    }()

    /// Returns the App build.
    static var build: String = {
        BEEApp.stringFromInfoDictionary(forKey: "CFBundleVersion")
    }()

    /// Returns the App executable.
    static var executable: String = {
        BEEApp.stringFromInfoDictionary(forKey: "CFBundleExecutable")
    }()

    /// Returns the App bundle.
    static var bundle: String = {
        BEEApp.stringFromInfoDictionary(forKey: "CFBundleIdentifier")
    }()

    // MARK: - Functions

    /// Returns a String from the Info dictionary of the App.
    ///
    /// - Parameter key: Key to search.
    /// - Returns: Returns a String from the Info dictionary of the App.
    private static func stringFromInfoDictionary(forKey key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary, let value = infoDictionary[key] as? String else {
            return ""
        }

        return value
    }
}

