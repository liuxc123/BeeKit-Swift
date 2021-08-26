//
//  StatefulViewable.swift
//  ProtocolTool
//
//  Created by liuxc on 2019/8/16.
//  Copyright © 2019 liuxc. All rights reserved.
//

import UIKit

/// Represents all possible states of a stateful view controller
public enum StatefulViewState: String {
    case content = "content"
    case loading = "loading"
    case error = "error"
    case empty = "empty"
}

/// Protocol to provide a backing view for that stateful view controller
public protocol BackingViewProvider {
    /// The backing view, usually a UIViewController's view.
    /// All placeholder views will be added to this view instance.
    var backingView: UIView { get }
}

/// MARK: - StatefulViewable
/// StatefulViewable protocol may be adopted by a view controller or a view in order to transition to
/// error, loading or empty views.
public protocol StatefulViewable: class, BeeCompatible, BackingViewProvider, AssociatedObjectProtocol {

    /// The view state machine backing all state transitions
    var stateMachine: ViewStateMachine { get }

    /// The current transition state of the view controller.
    /// All states other than `Content` imply that there is a placeholder view shown.
    var currentState: StatefulViewState { get }

    /// The last transition state that was sent to the state machine for execution.
    /// This does not imply that the state is currently shown on screen. Transitions are queued up and
    /// executed in sequential order.
    var lastState: StatefulViewState { get }

    // MARK: Views

    /// Sets up the initial state of the view.
    /// This method should be called as soon as possible in a view or view controller's
    /// life cycle, e.g. `viewWillAppear:`, to transition to the appropriate state.
    func setupInitialViewState(_ completion: (() -> Void)?)

    /// Transitions the controller to the loading state and shows
    /// the loading view if there is no content shown already.
    ///
    /// - parameter animated:     true if the switch to the placeholder view should be animated, false otherwise
    func startLoading(animated: Bool, completion: (() -> Void)?)

    /// Ends the controller's loading state.
    /// If an error occurred, the error view is shown.
    /// If the `hasContent` method returns false after calling this method, the empty view is shown.
    ///
    /// - parameter animated:     true if the switch to the placeholder view should be animated, false otherwise
    /// - parameter error:        An error that might have occurred whilst loading
    func endLoading(animated: Bool, error: Error?, completion: (() -> Void)?)

    /// Transitions the view to the appropriate state based on the `loading` and `error`
    /// input parameters and shows/hides corresponding placeholder views.
    ///
    /// - parameter loading:        true if the controller is currently loading
    /// - parameter error:        An error that might have occurred whilst loading
    /// - parameter animated:    true if the switch to the placeholder view should be animated, false otherwise
    func transitionViewStates(loading: Bool, error: Error?, animated: Bool, completion: (() -> Void)?)

    // MARK: Content and error handling

    /// Return true if content is available in your controller.
    ///
    /// - returns: true if there is content available in your controller.
    func hasContent() -> Bool

    /// This method is called if an error occurred, but `hasContent` returned true.
    /// You would typically display an unobstrusive error message that is easily dismissable
    /// for the user to continue browsing content.
    ///
    /// - parameter error:    The error that occurred
    func handleErrorWhenContentAvailable(_ error: Error)
}
