import UIKit

public class LimitSearchBarExecutor: LimitInputDelegate, UISearchBarDelegate {

    @available(iOS 2.0, *)
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return textInputDelegate?.searchBarShouldBeginEditing?(searchBar) ?? true
    }

    @available(iOS 2.0, *)
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        textInputDelegate?.searchBarTextDidBeginEditing?(searchBar)
    }

    @available(iOS 2.0, *)
    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool{
        return textInputDelegate?.searchBarShouldEndEditing?(searchBar) ?? true
    }

    @available(iOS 2.0, *)
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        textInputDelegate?.searchBarTextDidEndEditing?(searchBar)
    }

    @available(iOS 2.0, *)
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        textInputDelegate?.searchBar?(searchBar, textDidChange: searchText)
        DispatchQueue.main.async {
            guard let searchBar = searchBar as? LimitSearchBar, let input = searchBar.searchField else { return }
            guard let ir = searchBar.textDidChange(input: input, text: searchText) else {
                searchBar.textDidChangeEvent?(searchBar.text ?? "")
                return
            }
            searchBar.text = ir.text
            (input as UITextInput).selectedRange = ir.range
            searchBar.textDidChangeEvent?(ir.text)
        }
    }

    @available(iOS 3.0, *)
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let flag = textInputDelegate?.searchBar?(searchBar, shouldChangeTextIn: range, replacementText: text),!flag { return flag }
        guard  let searchBar = searchBar as? LimitSearchBar, let input = searchBar.searchField else { return true }
        return searchBar.shouldChange(input: input, range: range, string: text)
    }

    @available(iOS 2.0, *)
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textInputDelegate?.searchBarSearchButtonClicked?(searchBar)
    }

    @available(iOS 2.0, *)
    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        textInputDelegate?.searchBarBookmarkButtonClicked?(searchBar)
    }

    @available(iOS 2.0, *)
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        textInputDelegate?.searchBarCancelButtonClicked?(searchBar)
    }

    @available(iOS 3.2, *)
    public func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        textInputDelegate?.searchBarResultsListButtonClicked?(searchBar)
    }

    @available(iOS 3.0, *)
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        textInputDelegate?.searchBar?(searchBar, selectedScopeButtonIndexDidChange: selectedScope)
    }

}
