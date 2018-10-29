
import UIKit

class LoaderView: UIView {
    
    private enum Layout {
        static let arcInsets: UIEdgeInsets = UIEdgeInsets(top: 26, left: 26, bottom: 26, right: 26)
        static let backgroundInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        static let arcLineWidth: CGFloat = 8.0
    }
    
    private let arcLayer: CAShapeLayer = {
        let arcLayer = CAShapeLayer()
        arcLayer.fillColor = UIColor.clear.cgColor
        arcLayer.lineWidth = Layout.arcLineWidth
        arcLayer.lineCap = CAShapeLayerLineCap.round
        arcLayer.strokeStart = 0.0
        arcLayer.strokeEnd = 0.0
        return arcLayer
    }()
    
    private let arcColor: UIColor
    
    init(frame: CGRect,
         arcColor: UIColor) {
        self.arcColor = arcColor
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        arcLayer.strokeColor = arcColor.cgColor
        backgroundColor = UIColor.clear
        layer.addSublayer(arcLayer)
    }
}


// MARK: Draw

extension LoaderView {
    override func draw(_ rect: CGRect) {

        super.draw(rect)
        
        arcLayer.path = UIBezierPath(arcCenter: CGPoint(x: rect.midX,
                                                        y: rect.midY),
                                     radius: (rect.inset(by: Layout.arcInsets).width/2),
                                     startAngle: 0.0,
                                     endAngle: CGFloat(Double.pi * 2.0),
                                     clockwise: true).cgPath

        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }

        ctx.saveGState()
        drawBackground(in: rect,
                       with: ctx)
        ctx.restoreGState()
        ctx.saveGState()
    }

    private func drawBackground(in rect: CGRect,
                                with ctx: CGContext) {

        let shadowSize: CGFloat = 50.0
        let shadowRect = rect.insetBy(dx: shadowSize, dy: shadowSize)
        ctx.setShadow(offset: CGSize(width: 2, height: 2),
                      blur: 10,
                      color: UIColor.black.withAlphaComponent(0.26).cgColor)
        ctx.fill(shadowRect)


        let backgroundRect = rect.inset(by: Layout.backgroundInsets)
        let path = UIBezierPath(ovalIn: backgroundRect)

        ctx.addPath(path.cgPath)
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillPath()
        ctx.setLineWidth(0.5)
        ctx.setStrokeColor(Palette.midGray.cgColor)
        ctx.setFillColor(UIColor.clear.cgColor)
        ctx.addPath(path.cgPath)
        ctx.strokePath()
    }
}


// MARK: Animations

extension LoaderView {
    
    private enum AnimationKeys: String {
        case strokeEnd, strokeStart, strokeAnimation
    }
    
    func startAnimating() {
        becomeVisible()
        arcLayer.removeAllAnimations()
        let strokeEndAnimation = CABasicAnimation(keyPath: AnimationKeys.strokeEnd.rawValue)
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.beginTime = 0
        strokeEndAnimation.duration = 0.5
        
        let strokeStartAnimation = CABasicAnimation(keyPath: AnimationKeys.strokeStart.rawValue)
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = 0.15
        strokeStartAnimation.duration = 0.35
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 0.5
        animationGroup.repeatCount = Float.infinity
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]
        
        arcLayer.add(animationGroup, forKey: AnimationKeys.strokeAnimation.rawValue)
    }
    
    func stopAnimating() {
        
        UIView.animate(withDuration: 0.26,
                       delay: 1.0,
                       animations: { [weak self] in
                        self?.hide()
            })
    }
    
    private func becomeVisible() {
        alpha = 1.0
    }
    
    private func hide() {
        alpha = 0
    }
}
