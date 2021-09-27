//
//  CustomView.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/26/21.
//  Copyright © 2021 eramint.com. All rights reserved.
//

import UIKit

class CustomView: UIView {
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
     override func draw(_ rect: CGRect) {
         let grayPath = UIBezierPath()
         addArcs(
             to: grayPath,
             pointsAndRadii: [
                 (point: CGPoint(x: 0, y: 15), radius: 28),
                 (point: CGPoint(x: 0.0 , y: self.frame.size.height ), radius: 28),
                 (point: CGPoint(x: self.frame.size.width, y: self.frame.size.height), radius: 28),
                 (point: CGPoint(x: self.frame.size.width  , y: 0), radius: 28)
             ])
         UIColor.orange.setFill()
         grayPath.fill()
         grayPath.close()
         //grayPath.lineWidth = 2
         //UIColor.gray.setStroke()
        // grayPath.stroke()
     }

}



extension Collection where Index == Int {
    func items(at index: Index) -> (previous: Element, current: Element, next: Element) {
        precondition(count > 2)
        let previous = self[index == 0 ? count - 1 : index - 1]
        let current = self[index]
        let next = self[(index + 1) % count]
        return (previous, current, next)
    }
}

/// Returns ∠abc (i.e. clockwise degrees from ba to bc)
//
//  b - - - a
//   \
//    \
//     \
//      c
//
func angleBetween3Points(_ a: CGPoint, _ b: CGPoint, _ c: CGPoint) -> CGFloat {
    let xbaAngle = (a - b).angle
    let xbcAngle = (c - b).angle // if you were to put point b at the origin, `xbc` refers to the angle formed from the x-axis to the bc line (clockwise)
    let abcAngle = xbcAngle - xbaAngle
    return CGPoint(angle: abcAngle).angle // normalize angle between -π to π
}

func arcInfo(
    previous: CGPoint,
    current: CGPoint,
    next: CGPoint,
    radius: CGFloat)
    -> (center: CGPoint, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
{
    let a = previous
    let b = current
    let bCornerRadius: CGFloat = radius
    let c = next

    let abcAngle: CGFloat = angleBetween3Points(a, b, c)
    let xbaAngle = (a - b).angle
    let abeAngle = abcAngle / 2

    let deLength: CGFloat = bCornerRadius
    let bdLength = bCornerRadius / tan(abeAngle)
    let beLength = sqrt(deLength*deLength + bdLength*bdLength)

    let beVector: CGPoint = CGPoint(angle: abcAngle/2 + xbaAngle)

    let e: CGPoint = b + beVector * beLength

    let xebAngle = (b - e).angle
    let bedAngle = (π/2 - abs(abeAngle)) * abeAngle.sign() * -1

    return (
        center: e,
        startAngle: xebAngle - bedAngle,
        endAngle: xebAngle + bedAngle,
        clockwise: abeAngle < 0)
}

func addArcs(to path: UIBezierPath, pointsAndRadii: [(point: CGPoint, radius: CGFloat)]) {
    precondition(pointsAndRadii.count > 2)

    for i in 0..<pointsAndRadii.count {
        let (previous, current, next) = pointsAndRadii.items(at: i)
        let (center, startAngle, endAngle, clockwise) = arcInfo(
            previous: previous.point,
            current: current.point,
            next: next.point,
            radius: current.radius)

        path.addArc(withCenter: center, radius: current.radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
}

