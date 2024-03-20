import UIKit

final class RefreshControlControllerView: UIView {
    let controller: any RefreshControlControllable
    
    init(controller: any RefreshControlControllable) {
        self.controller = controller
        super.init(frame: .null)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        controller.scrollView = superview as? UIScrollView
    }
}

extension UIScrollView {
    var controllerViewTag: Int { 90973827 }
    
    public var refreshControlController: (any RefreshControlControllable)? {
        get {
            let controllerView = viewWithTag(controllerViewTag) as? RefreshControlControllerView
            return controllerView?.controller
        }
        set {
            viewWithTag(controllerViewTag)?.removeFromSuperview()
            if let newValue {
                let controllerView = RefreshControlControllerView(controller: newValue)
                controllerView.tag = controllerViewTag
                addSubview(controllerView)
            }
        }
    }
}

extension UITableViewController {
    @MainActor
    public var refreshControlController: (any RefreshControlControllable)? {
        get { tableView.refreshControlController }
        set { tableView.refreshControlController = newValue }
    }
}
