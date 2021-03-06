import Foundation
import LocalAuthentication

// MARK: - BEEBiometrics struct

/// This struct adds some useful functions to use biometric authentications.
public enum BEEBiometrics {
    // MARK: - Variables

    /// Biometric result enum.
    public enum Result: String {
        /// Success.
        case success
        /// Authentication Failed.
        case authenticationFailed
        /// User Cancel.
        case userCancel
        /// User Fallback.
        case userFallback
        /// System Cancel.
        case systemCancel
        /// Passcode Not Set.
        case passcodeNotSet
        /// Biometric Not Available.
        case notAvailable
        /// Biometric Not Enrolled.
        case notEnrolled
        /// Biometric Lockout.
        case lockout
        /// App Cancel.
        case appCancel
        /// Invalid Context.
        case invalidContext
        /// Not Interactive.
        case notInteractive
        /// Error.
        case error
    }

    // MARK: - Functions

    /// Returns if the Biometrics authentication can be used.
    ///
    /// - Returns: Returns an error code as Result enum.
    public static func canUseBiometric() -> Result {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return .success
        } else {
            return handleError(error)
        }
    }

    /// Shows the Biometrics authentication.
    ///
    /// - Parameters:
    ///   - reason:        Text to show in the alert.
    ///   - fallbackTitle: Default title "Enter Password" is used when this property is left nil. If set to empty string, the button will be hidden.
    ///   - completion:    Completion handler.
    ///   - result:        Returns the Biometrics result, from the Result enum.
    public static func useBiometric(localizedReason: String, fallbackTitle: String? = nil, completion: @escaping (_ result: Result) -> Void) {
        let context = LAContext()

        context.localizedFallbackTitle = fallbackTitle

        let canUseBiometric = self.canUseBiometric()
        if canUseBiometric == .success {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason) { success, error in
                if success == true, error == nil {
                    completion(.success)
                } else {
                    completion(handleError(error as NSError?))
                }
            }
        } else {
            completion(canUseBiometric)
        }
    }

    /// Handles the Biometrics errors.
    ///
    /// - Parameter error: Error.
    /// - Returns: Returns the error as Result enum.
    private static func handleError(_ error: NSError?) -> BEEBiometrics.Result {
        guard let error = error else {
            return .error
        }

        return handleErrorOS9(error)
    }

    /// Handles the Biometrics errors for iOS 11 or below.
    ///
    /// - Parameter error: Error.
    /// - Returns: Returns the error as Result enum.
    @available(iOS 11.0, *)
    private static func handleErrorOS11(_ error: NSError) -> Result {
        switch error {
        case LAError.authenticationFailed:
            return .authenticationFailed

        case LAError.userCancel:
            return .userCancel

        case LAError.userFallback:
            return .userFallback

        case LAError.systemCancel:
            return .systemCancel

        case LAError.passcodeNotSet:
            return .passcodeNotSet

        case LAError.biometryNotAvailable:
            return .notAvailable

        case LAError.biometryNotEnrolled:
            return .notEnrolled

        case LAError.biometryLockout:
            return .lockout

        case LAError.appCancel:
            return .appCancel

        case LAError.invalidContext:
            return .invalidContext

        case LAError.notInteractive:
            return .notInteractive

        default:
            return .error
        }
    }

    /// Handles the Biometrics errors for iOS 9 or below.
    ///
    /// - Parameter error: Error.
    /// - Returns: Returns the error as Result enum.
    @available(iOS 9.0, *)
    private static func handleErrorOS9(_ error: NSError) -> Result {
        if #available(iOS 11.0, *) {
            return handleErrorOS11(error)
        } else {
            switch error {
            case LAError.authenticationFailed:
                return .authenticationFailed

            case LAError.userCancel:
                return .userCancel

            case LAError.userFallback:
                return .userFallback

            case LAError.systemCancel:
                return .systemCancel

            case LAError.passcodeNotSet:
                return .passcodeNotSet

            case LAError.touchIDNotAvailable:
                return .notAvailable

            case LAError.touchIDNotEnrolled:
                return .notEnrolled

            case LAError.touchIDLockout:
                return .lockout

            case LAError.appCancel:
                return .appCancel

            case LAError.invalidContext:
                return .invalidContext

            case LAError.notInteractive:
                return .notInteractive

            default:
                return .error
            }
        }
    }
}

