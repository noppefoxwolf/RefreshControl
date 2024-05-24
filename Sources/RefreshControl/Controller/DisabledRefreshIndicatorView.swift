import UIKit
import SwiftUI

public final class DisabledRefreshIndicatorView: UIView {
    public init<RootView: View>(rootView: RootView) {
        super.init(frame: .null)
        let contentView = _UIHostingView(rootView: rootView)
        clipsToBounds = true
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let scrollView = superview as? UIScrollView {
            translatesAutoresizingMaskIntoConstraints = false
            let topConstraint = topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor)
            topConstraint.priority = .defaultLow
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
                scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
                topConstraint,
            ])
        }
    }
}

extension UIScrollView {
    private var disabledRefreshIndicatorViewTag: Int { 1234567890 }
    
    public var disabledRefreshIndicatorView: DisabledRefreshIndicatorView? {
        get { viewWithTag(disabledRefreshIndicatorViewTag) as? DisabledRefreshIndicatorView }
        set {
            viewWithTag(disabledRefreshIndicatorViewTag)?.removeFromSuperview()
            if let newValue {
                newValue.tag = disabledRefreshIndicatorViewTag
                addSubview(newValue)
            }
        }
    }
}
