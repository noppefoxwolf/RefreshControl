import UIKit

/// Archtecture like UIRefreshControlModernContentView
/// See also https://headers.cynder.me/index.php?sdk=ios/16.0&fw=PrivateFrameworks/UIKitCore.framework&file=Headers%2F_UIRefreshControlModernContentView.h
final class RefreshControlContentView: UIView {
    let arrowImageView = UIImageView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    init() {
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
    
    func spin() {
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        arrowImageView.isHidden = true
    }
    
    func cleanUp() {
        UIView.animate(
            withDuration: CATransaction.animationDuration(),
            animations: { [weak self] in
                self?.activityIndicator.alpha = 0
            }, completion: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
                self?.arrowImageView.isHidden = false
            }
        )
    }
    
    func reverse() {
        arrowImageView.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func unreverse() {
        arrowImageView.transform = .identity
    }
}
