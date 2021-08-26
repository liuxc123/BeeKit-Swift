//
//  StatefulViewableImpl.swift
//  ProtocolTool
//
//  Created by liuxc on 2019/8/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit

// MARK: Default Implementation BackingViewProvider

extension BackingViewProvider where Self: UIViewController {
    public var backingView: UIView {
        return view
    }
}

extension BackingViewProvider where Self: UIView {
    public var backingView: UIView {
        return self
    }
}

// MARK: Default Implementation StatefulViewable

extension StatefulViewable {

    public var stateMachine: ViewStateMachine {
        return associatedObject(forKey: &stateMachineKey, default: ViewStateMachine(view: backingView))
    }

    public var currentState: StatefulViewState {
        switch stateMachine.currentState {
        case .none: return .content
        case .view(let viewKey): return StatefulViewState(rawValue: viewKey)!
        }
    }

    public var lastState: StatefulViewState {
        switch stateMachine.lastState {
        case .none: return .content
        case .view(let viewKey): return StatefulViewState(rawValue: viewKey)!
        }
    }

    // MARK: Views

    fileprivate var loadingView: UIView? {
        get { return placeholderView(.loading) }
        set { setPlaceholderView(newValue, forState: .loading) }
    }

    fileprivate var errorView: UIView? {
        get { return placeholderView(.error) }
        set { setPlaceholderView(newValue, forState: .error) }
    }

    fileprivate var emptyView: UIView? {
        get { return placeholderView(.empty) }
        set { setPlaceholderView(newValue, forState: .empty) }
    }

    // MARK: Transitions

    public func setupInitialViewState(_ completion: (() -> Void)? = nil) {
        let isLoading = (lastState == .loading)
        let error: NSError? = (lastState == .error) ? NSError(domain: "com.prot.StatefulViewable.ErrorDomain", code: -1, userInfo: nil) : nil
        transitionViewStates(loading: isLoading, error: error, animated: false, completion: completion)
    }

    public func startLoading(animated: Bool = false, completion: (() -> Void)? = nil) {
        transitionViewStates(loading: true, animated: animated, completion: completion)
    }

    public func endLoading(animated: Bool = true, error: Error? = nil, completion: (() -> Void)? = nil) {
        transitionViewStates(loading: false, error: error, animated: animated, completion: completion)
    }

    public func transitionViewStates(loading: Bool = false, error: Error? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        // Update view for content (i.e. hide all placeholder views)
        if hasContent() {
            if let e = error {
                handleErrorWhenContentAvailable(e)
            }
            self.stateMachine.transitionToState(.none, animated: animated, completion: completion)
            return
        }

        // Update view for placeholder
        var newState: StatefulViewState = .empty
        if loading {
            newState = .loading
        } else if let _ = error {
            newState = .error
        }
        self.stateMachine.transitionToState(.view(newState.rawValue), animated: animated, completion: completion)
    }

    // MARK: Content and error handling

    public func hasContent() -> Bool {
        return true
    }

    public func handleErrorWhenContentAvailable(_ error: Error) {
        // Default implementation does nothing.
    }

    // MARK: Helper

    fileprivate func placeholderView(_ state: StatefulViewState) -> UIView? {
        return stateMachine[state.rawValue]
    }

    fileprivate func setPlaceholderView(_ view: UIView?, forState state: StatefulViewState) {
        stateMachine[state.rawValue] = view
    }

}

// MARK: Association

private var stateMachineKey: String = "stateMachineKey"

// MARK: NameSpace

public extension Bee where Base: StatefulViewable {

    // MARK: Views

    var loadingView: UIView? {
        get { return self.base.loadingView }
        set { self.base.loadingView = newValue }
    }

    var errorView: UIView? {
        get { return self.base.errorView }
        set { self.base.errorView = newValue }
    }

    var emptyView: UIView? {
        get { return self.base.emptyView }
        set { self.base.emptyView = newValue }
    }

    // MARK: Transitions

    func startLoading(animated: Bool = false, completion: (() -> Void)? = nil) {
        self.base.startLoading(animated: animated, completion: completion)
    }

    func endLoading(animated: Bool = true, error: Error? = nil, completion: (() -> Void)? = nil) {
        self.base.endLoading(animated: animated, error: error, completion: completion)
    }

}
