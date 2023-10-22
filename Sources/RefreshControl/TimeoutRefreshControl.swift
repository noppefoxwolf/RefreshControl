import UIKit
import Combine

open class TimeoutRefreshControl: OvertimeRefreshControl {
    public var timeoutInterval: DispatchQueue.SchedulerTimeType.Stride? = nil
    public var onTimeout: (() -> Void)? = nil
    var cancellable: AnyCancellable? = nil
    
    public override init() {
        super.init()
        
        addAction(UIAction { [weak self] _ in
            self?.startTimer()
        }, for: .primaryActionTriggered)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
        invalidateTimer()
    }
    
    func startTimer() {
        guard cancellable == nil else { return }
        guard let interval = timeoutInterval else { return }
        cancellable = Timer
            .publish(every: 1, on: .main, in: .default, options: nil)
            .autoconnect()
            .measureInterval(using: DispatchQueue.main)
            .scan(0, +)
            .first(where: { $0 > interval })
            .sink { [weak self] _ in
                self?.onTimeout?()
                self?.endRefreshing()
            }
    }
    
    func invalidateTimer() {
        cancellable = nil
    }
}
