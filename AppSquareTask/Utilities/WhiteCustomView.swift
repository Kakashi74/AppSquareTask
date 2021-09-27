//
//  WhiteCustomView.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/27/21.
//  Copyright © 2021 All rights reserved.
//

import Foundation
import UIKit


class WhiteCustomView : UIView {
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
                    (point: CGPoint(x: self.frame.size.width  , y: 3), radius: 8) ,
                    (point: CGPoint(x: self.frame.size.width, y: self.frame.size.height), radius: 8) ,
                    (point: CGPoint(x: 3 , y: self.frame.size.height ), radius: 8) ,
                    (point: CGPoint(x: 0, y: 0), radius: 8)
//                     (point: CGPoint(x: 0, y: 30), radius: 28),
//                     (point: CGPoint(x: 0.0 , y: self.frame.size.height ), radius: 28),
//                     (point: CGPoint(x: self.frame.size.width, y: self.frame.size.height), radius: 28),
//                     (point: CGPoint(x: self.frame.size.width  , y: 0), radius: 28)
                 ])
             UIColor.white.setFill()
             grayPath.fill()
             grayPath.close()
             //grayPath.lineWidth = 2
             //UIColor.gray.setStroke()
            // grayPath.stroke()
         }

    }
