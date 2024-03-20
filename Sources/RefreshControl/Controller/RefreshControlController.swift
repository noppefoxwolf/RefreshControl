import UIKit

@MainActor
public protocol RefreshControlControllable: AnyObject {
    associatedtype RefreshControl: UIRefreshControl
    var refreshControl: RefreshControl { get }
    var scrollView: UIScrollView? { get set }
    var isEnabled: Bool { get set }
}

public final class RefreshControlController<RefreshControl: UIRefreshControl>: Sendable, RefreshControlControllable {
    public let refreshControl: RefreshControl
    public let disabledRefreshIndicatorView: DisabledRefreshIndicatorView
    public weak var scrollView: UIScrollView? = nil {
        didSet { updateControls() }
    }
    
    public init(
        refreshControl: RefreshControl,
        disabledRefreshIndicatorView: DisabledRefreshIndicatorView
    ) {
        self.refreshControl = refreshControl
        self.disabledRefreshIndicatorView = disabledRefreshIndicatorView
    }
    
    public var isEnabled: Bool = true {
        didSet {
            updateControls()
        }
    }
    
    func updateControls() {
        if isEnabled {
            scrollView?.refreshControl = refreshControl
            scrollView?.disabledRefreshIndicatorView = nil
        } else {
            scrollView?.refreshControl = nil
            scrollView?.disabledRefreshIndicatorView = disabledRefreshIndicatorView
        }
    }
}
