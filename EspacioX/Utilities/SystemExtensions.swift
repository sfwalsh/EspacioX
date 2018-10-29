
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

extension UIStackView {
    
    func addArrangedSubviews(views: [UIView]) {
        views.forEach({addArrangedSubview($0)})
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension String {
    
    func biFontString(forPrimaryFont primaryFont: UIFont,
                      highlightedFont: UIFont,
                      textColor: UIColor,
                      highlightedText: String) -> NSAttributedString {
        let primaryTextAttributes = [NSAttributedString.Key.font: primaryFont,
                                     NSAttributedString.Key.foregroundColor: textColor]
        let highlightedTextAttributes = [NSAttributedString.Key.font: highlightedFont,
                                         NSAttributedString.Key.foregroundColor: textColor]
        let attributedString = NSMutableAttributedString(string: self, attributes: primaryTextAttributes)
        
        let highlightedRange = (attributedString.string as NSString).range(of: highlightedText)
        
        attributedString.setAttributes(highlightedTextAttributes, range: highlightedRange)
        return attributedString
    }
}
