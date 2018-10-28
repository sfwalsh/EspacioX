
import UIKit

final class GradientView: UIView {
    
    private let gradiantLayer: CAGradientLayer
    
    init(frame: CGRect,
         topColor: UIColor,
         bottomColor: UIColor) {
        self.gradiantLayer = GradientView.createGradientLayer(topColor: topColor,
                                                              bottomColor: bottomColor)
        super.init(frame: frame)
        
        layer.insertSublayer(gradiantLayer, at: 0)
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    // MARK: Static helpers
    
    private static func createGradientLayer(topColor: UIColor,
                                            bottomColor: UIColor) -> CAGradientLayer  {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        return layer
    }
    
    
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradiantLayer.frame = rect
    }
}
