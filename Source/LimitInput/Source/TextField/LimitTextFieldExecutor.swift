import UIKit

class LimitTextFieldExecutor: LimitInputDelegate, UITextFieldDelegate {

    @available(iOS 2.0, *)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return textInputDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    @available(iOS 2.0, *)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textInputDelegate?.textFieldDidBeginEditing?(textField)
    }

    @available(iOS 2.0, *)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return textInputDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    @available(iOS 2.0, *)
    func textFieldDidEndEditing(_ textField: UITextField) {
        textInputDelegate?.textFieldDidEndEditing?(textField)
    }

    @available(iOS 2.0, *)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return textInputDelegate?.textFieldShouldClear?(textField) ?? true
    }

    @available(iOS 2.0, *)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textInputDelegate?.textFieldShouldReturn?(textField) ?? true
    }

    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textInputDelegate?.textFieldDidEndEditing?(textField, reason: reason)
        textInputDelegate?.textFieldDidEndEditing?(textField)
    }

    @available(iOS 2.0, *)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let flag = textInputDelegate?.textField?(textField,shouldChangeCharactersIn: range, replacementString: string),!flag { return flag }
        guard let input = textField as? LimitTextField else { return true }
        return input.shouldChange(input: input, range: range, string: string)
    }

    @available(iOS 13.0, *)
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textInputDelegate?.textFieldDidChangeSelection?(textField)
    }
}
