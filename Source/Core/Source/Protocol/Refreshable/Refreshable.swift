import Foundation
import UIKit

// MARK:- Refreshable && RefreshControllable
// Refreshable 需要使用 「刷新功能」 时使用
// RefreshControllable 控制刷新状态
public protocol Refreshable: BeeCompatible { }
public protocol RefreshControllable: AnyObject, AssociatedObjectProtocol, BeeCompatible { }

private var scrollViewKey = "scrollViewKey"

// MARK: - Bee for RefreshControllable
public extension Bee where Base: RefreshControllable {

    private weak var scrollView: UIScrollView? {
        set { base.setAssociatedObject(newValue, forKey: &scrollViewKey) }
        get { base.associatedObject(forKey: &scrollViewKey) }
    }

    @discardableResult
    func refreshStatus(_ status:[RefreshModel.RefreshStatus]) -> Bee {
        scrollView?.bee.refreshStatus(status)
        return self
    }
}


// MARK: - Bee for Refreshable

public extension Bee where Base: Refreshable {

    @discardableResult
    func setupRefresh<T: RefreshControllable>(
        _ vm: T,
        _ scrollView: UIScrollView
        ) -> Bee {
        vm.bee.scrollView = scrollView
        return self
    }

}
