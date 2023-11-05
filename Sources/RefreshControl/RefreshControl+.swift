import UIKit

extension RefreshControl {
    public func startSilentRefreshing() {
        guard !isRefreshing else { return }
        isOffscreenRefreshing = true
        sendActions(for: .primaryActionTriggered)
    }
}
