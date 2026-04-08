import UIKit

extension UIView {

    func applyRightBubble(radius: CGFloat = 18) {
        layoutIfNeeded()

        let path = UIBezierPath()

        let width = self.bounds.width
        let height = self.bounds.height
        
        // Start top-left corner
        path.move(to: CGPoint(x: radius, y: 0))

        // Top edge to top-right
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: radius), controlPoint: CGPoint(x: width, y: 0))

        // Right edge down
        path.addLine(to: CGPoint(x: width, y: height - radius - 10))

        // ---- TAIL SHAPE ----
        path.addQuadCurve(to: CGPoint(x: width + 50, y: height),
                          controlPoint: CGPoint(x: width + 10, y: height - 2))

        path.addQuadCurve(to: CGPoint(x: width - 10, y: height - 5),
                          controlPoint: CGPoint(x: width - 4, y: height))

        // ---- Continue bottom-left corner ----
        path.addLine(to: CGPoint(x: radius, y: height))
        path.addQuadCurve(to: CGPoint(x: 0, y: height - radius),
                          controlPoint: CGPoint(x: 0, y: height))

        // Left edge up
        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addQuadCurve(to: CGPoint(x: radius, y: 0),
                          controlPoint: CGPoint(x: 0, y: 0))

        // Apply mask
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

