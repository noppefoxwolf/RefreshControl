import UIKit

extension UIRefreshControl {
    /// beginRefresh and trigger action.
    public func startRefreshing() {
        guard !isRefreshing else { return }
        beginRefreshing()
        sendActions(for: .primaryActionTriggered)
    }
    
    /// Checking refreshing and endRefresh with completion handler.
    public func finishRefreshing(
        _ completion: (() -> Void)? = nil
    ) {
        if isRefreshing {
            endRefreshing {
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    /// EndRefresh with completion handler.
    public func endRefreshing(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        endRefreshing()
        CATransaction.commit()
    }
}

extension UIRefreshControl {
    var scrollView: UIScrollView? {
        superview as? UIScrollView
    }
    
    var isOffscreen: Bool {
        window == nil
    }
}
