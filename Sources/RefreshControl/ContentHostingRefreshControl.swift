import os
import Combine
import UIKit

open class ContentHostingRefreshControl: AnywhereBeginRefreshControl {
    private var cancellables: Set<AnyCancellable> = []
    private var triggeredActionID: UIAction.Identifier { .init(#function) }
    let contentView = RefreshControlContentView()
    var revealedFraction: CGFloat { visibleHeight / snappingHeight }
    
    public override var attributedTitle: NSAttributedString? {
        get { contentView.textLabel.attributedText }
        set { contentView.textLabel.attributedText = newValue }
    }
    
    public override init() {
        super.init()
        loadView()
        addTriggeredAction()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        addTriggeredAction()
    }
    
    private func loadView() {
        /// hacking: enabled stretch style.
        backgroundColor = .clear
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    private func addTriggeredAction() {
        let action = UIAction(
            identifier: triggeredActionID,
            handler: { [unowned self] _ in
                contentView.spin()
            }
        )
        addAction(action, for: .primaryActionTriggered)
    }
    
    public override func removeAction(identifiedBy actionIdentifier: UIAction.Identifier, for controlEvents: UIControl.Event) {
        if actionIdentifier == triggeredActionID {
            fatalError("Don't remove internal action")
        }
        super.removeAction(identifiedBy: actionIdentifier, for: controlEvents)
    }
    
    /// hacking: override _updateSnappingHeight() implementation.
    /// The original method always reset snappingHeight when stretch style.
    @objc dynamic func _updateSnappingHeight() {
        snappingHeight = 60
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        removeSystemContentView()
        
        if let scrollView {
            scrollView.publisher(for: \.contentOffset).sink { [unowned self] _ in
                didScroll()
            }.store(in: &cancellables)
        } else {
            cancellables = []
        }
    }
    
    private func removeSystemContentView() {
        subviews
            .filter({ !($0 is RefreshControlContentView) })
            .forEach({ $0.removeFromSuperview() })
    }
    
    func didScroll() {
        if revealedFraction > 0.80 {
            UIView.animate(
                withDuration: CATransaction.animationDuration(),
                animations: { [weak self] in
                    self?.contentView.reverse()
                }
            )
        } else {
            UIView.animate(
                withDuration: CATransaction.animationDuration(),
                animations: { [weak self] in
                    self?.contentView.unreverse()
                }
            )
        }
    }
    
    public override func beginRefreshing() {
        super.beginRefreshing()
        contentView.spin()
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
        contentView.cleanUp()
    }
}
