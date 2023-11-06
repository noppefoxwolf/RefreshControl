import UIKit

/// Archtecture like UIRefreshControlModernContentView
/// See also https://headers.cynder.me/index.php?sdk=ios/16.0&fw=PrivateFrameworks/UIKitCore.framework&file=Headers%2F_UIRefreshControlModernContentView.h
public final class ArrowRefreshControlContentView: UIView, RefreshControlContentView, RefreshControlDelegate {
    let textLabel = UILabel()
    public var attributedText: NSAttributedString? {
        get { textLabel.attributedText }
        set { textLabel.attributedText = newValue }
    }
    let arrowImageView = UIImageView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    public init() {
        super.init(frame: .null)
        tintColor = .secondaryLabel
        
        addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: arrowImageView.bottomAnchor, constant: 10),
            arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        textLabel.textAlignment = .center
        textLabel.font = .preferredFont(forTextStyle: .caption1)
        textLabel.textColor = .secondaryLabel
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        arrowImageView.image = UIImage(
            systemName: "arrow.down",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 18,
                weight: .bold
            )
        )
        activityIndicator.hidesWhenStopped = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func didTriggered(_ refreshControl: UIRefreshControl) {
        textLabel.alpha = 1
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        arrowImageView.isHidden = true
    }
    
    public func didFinishRefreshing(_ refreshControl: UIRefreshControl) {
        UIView.animate(
            withDuration: CATransaction.animationDuration(),
            animations: { [weak self] in
                self?.activityIndicator.alpha = 0
                self?.textLabel.alpha = 0
            }, completion: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
                self?.arrowImageView.isHidden = false
            }
        )
    }
    
    public func refreshControl(_ refreshControl: UIRefreshControl, updated revealedFraction: Double) {
        if revealedFraction > 0.80 {
            UIView.animate(
                withDuration: CATransaction.animationDuration(),
                animations: { [weak self] in
                    self?.reverse()
                }
            )
        } else {
            UIView.animate(
                withDuration: CATransaction.animationDuration(),
                animations: { [weak self] in
                    self?.unreverse()
                }
            )
        }
    }
    
    private func reverse() {
        arrowImageView.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    private func unreverse() {
        arrowImageView.transform = .identity
    }
}
