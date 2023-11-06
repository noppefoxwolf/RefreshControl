import Foundation

public protocol RefreshControlContentView: AnyObject, RefreshControlDelegate {
    var attributedText: NSAttributedString? { get set }
}
