import UIKit

// Workaround for UIRefreshControlReceivedOffscreenBeginRefreshing
open class AnywhereBeginRefreshControl: _RefreshControl {
    var isOffscreenRefreshing: Bool = false
    
    open override var isRefreshing: Bool {
        super.isRefreshing || isOffscreenRefreshing
    }
    
    open override func didMoveToWindow() {
        super.didMoveToWindow()
        if !isOffscreen && isOffscreenRefreshing {
            onscreenBeginRefreshing()
        }
    }
    
    open override func beginRefreshing() {
        if isOffscreen {
            offscreenBeginRefreshing()
        } else {
            onscreenBeginRefreshing()
        }
    }
    
    func onscreenBeginRefreshing() {
        super.beginRefreshing()
    }
    
    func offscreenBeginRefreshing() {
        isOffscreenRefreshing = true
    }
    
    open override func endRefreshing() {
        super.endRefreshing()
        isOffscreenRefreshing = false
    }
}
