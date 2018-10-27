
import UIKit

extension UIView {
    
    func addSubviewsForAutolayout(views: [UIView]) {
        views.forEach({ addSubviewForAutolayout(view: $0) })
    }
    
    func addSubviewForAutolayout(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
