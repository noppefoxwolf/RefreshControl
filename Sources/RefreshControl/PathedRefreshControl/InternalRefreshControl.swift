import os
import UIKit

fileprivate let logger = Logger(
    subsystem: "dev.noppe.RefreshControl.logger",
    category: #file
)

/// The internal property accessible class.
/// See also https://headers.cynder.me/index.php?sdk=ios/16.0&fw=PrivateFrameworks/UIKitCore.framework&file=Headers/UIRefreshControl.h
open class InternalRefreshControl: UIRefreshControl {
    
    /// hacking: ignore undefined key access
    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
        logger.warning("\(#function) \(key)")
    }
    
    /// hacking: ignore undefined key access
    open override func value(forUndefinedKey key: String) -> Any? {
        logger.warning("\(#function) \(key)")
        return nil
    }
    
    // https://stackoverflow.com/a/58609277/1131587
    var snappingHeight: CGFloat {
        get { value(forKey: "_snappingHeight") as? CGFloat ?? 0 }
        set { setValue(newValue, forKey: "_snappingHeight") }
    }
    
    var refreshControlHeight: CGFloat {
        get { (value(forKey: "_refreshControlHeight") as? CGFloat) ?? 0 }
        set { setValue(newValue, forKey: "_refreshControlHeight") }
    }
    
    var visibleHeight: CGFloat {
        get { (value(forKey: "_visibleHeight") as? CGFloat) ?? 0 }
        set { setValue(newValue, forKey: "_visibleHeight") }
    }
    
    var appliedInsets: UIEdgeInsets {
        get { (value(forKey: "_appliedInsets") as? UIEdgeInsets) ?? .zero }
        set { setValue(newValue, forKey: "_appliedInsets") }
    }
    
    var additionalTopInset: CGFloat {
        get { (value(forKey: "_additionalTopInset") as? CGFloat) ?? 0 }
        set { setValue(newValue, forKey: "_additionalTopInset") }
    }
    
    var insetsApplied: Bool {
        get { (value(forKey: "_insetsApplied") as? Bool) ?? false }
        set { setValue(newValue, forKey: "_insetsApplied") }
    }
    
    var adjustingInsets: Bool {
        get { (value(forKey: "_adjustingInsets") as? Bool) ?? false }
        set { setValue(newValue, forKey: "_adjustingInsets") }
    }
    
    var hostAdjustsContentOffset: Bool {
        (value(forKey: "_hostAdjustsContentOffset") as? Bool) ?? false
    }
}

