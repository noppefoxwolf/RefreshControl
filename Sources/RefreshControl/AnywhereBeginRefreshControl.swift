import UIKit
import os

fileprivate let logger = Logger(
    subsystem: "dev.noppe.logger",
    category: #file
)

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
        logger.debug("\(#function)")
        super.beginRefreshing()
    }
    
    func offscreenBeginRefreshing() {
        logger.debug("\(#function)")
        isOffscreenRefreshing = true
    }
    
    open override func endRefreshing() {
        super.endRefreshing()
        isOffscreenRefreshing = false
    }
}
