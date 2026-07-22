//
//  UIView+Bubble.swift
//  MsgTableView
//
//  Created by Abdul Aleem on 19/11/25.
//

import UIKit

extension UIView {

    func applyRightBubble(radius: CGFloat = 12) {

        layoutIfNeeded()
        self.layer.mask = nil
        self.layer.sublayers?.filter { $0.name == "bubbleLayer" }.forEach { $0.removeFromSuperlayer() }

        let width  = self.bounds.width
        let height = self.bounds.height
        let color  = self.backgroundColor?.cgColor ?? UIColor.red.cgColor

       
        let tailWidth: CGFloat = 7
        let tailDip: CGFloat = 12

        let path = UIBezierPath()
        path.move(to: CGPoint(x: radius, y: 0))
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: radius), controlPoint: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height - tailDip - 4))

   
        path.addCurve(to: CGPoint(x: width + tailWidth, y: height - 2),
                      controlPoint1: CGPoint(x: width, y: height - 4),
                      controlPoint2: CGPoint(x: width + tailWidth, y: height - tailDip * 0.4))


        path.addCurve(to: CGPoint(x: width - tailWidth - 6, y: height),
                      controlPoint1: CGPoint(x: width + tailWidth, y: height + 1),
                      controlPoint2: CGPoint(x: width - 2, y: height + 2))

        path.addLine(to: CGPoint(x: radius, y: height))
        path.addQuadCurve(to: CGPoint(x: 0, y: height - radius), controlPoint: CGPoint(x: 0, y: height))

        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addQuadCurve(to: CGPoint(x: radius, y: 0), controlPoint: CGPoint(x: 0, y: 0))
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


        let tailWidth: CGFloat = 7
        let tailDip: CGFloat = 12

        let path = UIBezierPath()
        path.move(to: CGPoint(x: radius, y: 0))
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        path.addQuadCurve(to: CGPoint(x: width, y: radius), controlPoint: CGPoint(x: width, y: 0))

        path.addLine(to: CGPoint(x: width, y: height - radius))
        path.addQuadCurve(to: CGPoint(x: width - radius, y: height), controlPoint: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: tailWidth + 6, y: height))


        path.addCurve(to: CGPoint(x: -tailWidth, y: height - 2),
                      controlPoint1: CGPoint(x: 2, y: height + 2),
                      controlPoint2: CGPoint(x: -tailWidth, y: height + 1))


        path.addCurve(to: CGPoint(x: 0, y: height - tailDip - 4),
                      controlPoint1: CGPoint(x: -tailWidth, y: height - tailDip * 0.4),
                      controlPoint2: CGPoint(x: 0, y: height - 4))

        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addQuadCurve(to: CGPoint(x: radius, y: 0), controlPoint: CGPoint(x: 0, y: 0))
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
