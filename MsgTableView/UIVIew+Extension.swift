import UIKit

extension UIView {
    
    func applyRightBubble(radius: CGFloat = 12) {
        
        layoutIfNeeded()
        self.layer.mask = nil
        self.layer.sublayers?.filter { $0.name == "bubbleLayer" }.forEach { $0.removeFromSuperlayer() }

        let width  = self.bounds.width
        let height = self.bounds.height
        let color  = self.backgroundColor?.cgColor ?? UIColor.red.cgColor
        let path = UIBezierPath()
        path.move(to: CGPoint(x: radius, y: 0))
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: radius),controlPoint: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height - 14))
        
        path.addCurve(to:CGPoint(x: width + 6, y: height - 2),controlPoint1: CGPoint(x: width,y: height - 6),controlPoint2: CGPoint(x: width + 6, y: height - 8))
        path.addCurve(to:CGPoint(x: width - 8, y: height),controlPoint1: CGPoint(x: width + 6, y: height + 2),controlPoint2: CGPoint(x: width,y: height + 2))
        
        path.addLine(to: CGPoint(x: radius, y: height))
        path.addQuadCurve(to: CGPoint(x: 0, y: height - radius),controlPoint: CGPoint(x: 0, y: height))

        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addQuadCurve(to: CGPoint(x: radius, y: 0),controlPoint: CGPoint(x: 0, y: 0))
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "bubbleLayer"
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = color
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    func applyLeftBubble(radius: CGFloat = 12) {
        
        layoutIfNeeded()
        self.layer.mask = nil
        self.layer.sublayers?.filter { $0.name == "bubbleLayer" }.forEach { $0.removeFromSuperlayer() }
        
        let width  = self.bounds.width
        let height = self.bounds.height
        let color  = self.backgroundColor?.cgColor ?? UIColor.white.cgColor
        let path = UIBezierPath()
        path.move(to: CGPoint(x: radius, y: 0))
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: radius), controlPoint: CGPoint(x: width, y: 0))
        
        path.addLine(to: CGPoint(x: width, y: height - radius))
        path.addQuadCurve(to: CGPoint(x: width - radius, y: height),controlPoint: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 8, y: height))
        path.addCurve(to:CGPoint(x: -6, y: height - 2),controlPoint1: CGPoint(x: 0,  y: height + 2),controlPoint2: CGPoint(x: -6, y: height + 2))
        path.addCurve(to:CGPoint(x: 0,  y: height - 14),controlPoint1: CGPoint(x: -6, y: height - 8),controlPoint2: CGPoint(x: 0,  y: height - 6))
        
        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addQuadCurve(to: CGPoint(x: radius, y: 0),controlPoint: CGPoint(x: 0, y: 0))
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "bubbleLayer"
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = color
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}
