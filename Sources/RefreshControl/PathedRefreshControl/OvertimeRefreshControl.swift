import UIKit
import Combine

open class OvertimeRefreshControl: ContentHostingRefreshControl {
    public var timeoverInterval: DispatchQueue.SchedulerTimeType.Stride? = nil
    public var timeoverAttributedTitle: NSAttributedString? = nil
    
    private var defaultAttributedTitle: NSAttributedString? = nil
    
    private var cancellable: AnyCancellable? = nil
    
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
    
    private func startTimer() {
        guard cancellable == nil else { return }
        guard let interval = timeoverInterval else { return }
        defaultAttributedTitle = attributedTitle
        cancellable = Timer
            .publish(every: 1, on: .main, in: .default, options: nil)
            .autoconnect()
            .measureInterval(using: DispatchQueue.main)
            .scan(0, +)
            .first(where: { $0 > interval })
            .sink { [weak self] _ in
                self?.attributedTitle = self?.timeoverAttributedTitle
            }
    }
    
    private func invalidateTimer() {
        cancellable = nil
        attributedTitle = defaultAttributedTitle
    }
}
