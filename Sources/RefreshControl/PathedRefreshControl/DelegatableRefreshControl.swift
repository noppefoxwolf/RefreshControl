import UIKit
import Combine

@MainActor
public protocol RefreshControlDelegate: AnyObject {
    func refreshControl(_ refreshControl: UIRefreshControl, updated revealedFraction: Double)
    func didTriggered(_ refreshControl: UIRefreshControl)
    func didFinishRefreshing(_ refreshControl: UIRefreshControl)
}

open class DelegatableRefreshControl: WaitHostingRefreshControl {
    class Weak {
        weak var value: (any RefreshControlDelegate)?
        init(value: any RefreshControlDelegate) {
            self.value = value
        }
    }
    private var delegates = [Weak]()
    public func addDelegate(_ delegate: RefreshControlDelegate) {
        delegates.append(Weak(value: delegate))
    }
    
    private var contentOffsetObserver: AnyCancellable? = nil
    private var triggeredActionID: UIAction.Identifier { .init(#function) }
    var revealedFraction: CGFloat { visibleHeight / snappingHeight }
    
    public override init() {
        super.init()
        addTriggeredAction()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTriggeredAction() {
        let action = UIAction(
            identifier: triggeredActionID,
            handler: { [unowned self] _ in
                delegates.forEach {
                    $0.value?.didTriggered(self)
                }
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
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let scrollView {
            contentOffsetObserver = scrollView
                .publisher(for: \.contentOffset)
                .sink { [unowned self] _ in
                    didScroll()
                }
        } else {
            contentOffsetObserver = nil
        }
    }
    
    func didScroll() {
        delegates.forEach {
            $0.value?.refreshControl(
                self,
                updated: revealedFraction
            )
        }
    }
    
    public override func beginRefreshing() {
        super.beginRefreshing()
        delegates.forEach {
            $0.value?.didTriggered(self)
        }
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
        delegates.forEach {
            $0.value?.didFinishRefreshing(self)
        }
    }
}
