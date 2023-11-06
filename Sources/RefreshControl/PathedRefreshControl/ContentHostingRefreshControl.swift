import os
import Combine
import UIKit

open class ContentHostingRefreshControl: DelegatableRefreshControl {
    public typealias ContentView = any RefreshControlContentView & UIView
    var contentView: ContentView = ArrowRefreshControlContentView()
    
    public override var attributedTitle: NSAttributedString? {
        get { contentView.attributedText }
        set { contentView.attributedText = newValue }
    }
    
    public override init() {
        super.init()
        /// hacking: enabled stretch style.
        backgroundColor = .clear
        setContentView(contentView)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setContentView(_ contentView: ContentView) {
        contentView.removeFromSuperview()
        self.contentView = contentView
        addDelegate(contentView)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    /// hacking: override _updateSnappingHeight() implementation.
    /// The original method always reset snappingHeight when stretch style.
    @objc dynamic func _updateSnappingHeight() {
        snappingHeight = 60
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        removeSystemContentView()
    }
    
    private func removeSystemContentView() {
        subviews
            .filter({ !($0 is RefreshControlContentView) })
            .forEach({ $0.removeFromSuperview() })
    }
}
