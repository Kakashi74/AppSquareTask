//
//  DemoView.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/7/21.
//  Copyright © 2021 eramint.com. All rights reserved.
//

import UIKit

class DemoView : UIView {
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.createRectangle(rect: rect)
    }
    
    func createRectangle(rect : CGRect) {
        // Initialize the path.
        path = UIBezierPath()
        
        // Specify the point that the path should start get drawn.
        path.move(to: CGPoint( x: 30.0   , y:  50.0 ))
        
        // Create a line between the starting point and the bottom-left side of the view.
        path.addLine(to: CGPoint(x: 0.0 , y: self.frame.size.height ))
        
        // Create the bottom line (bottom-left to bottom-right).
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        // Create the vertical line from the bottom-right to the top-right side.
        path.addLine(to: CGPoint(x: self.frame.size.width  , y: 0.0))
        UIColor.orange.setFill()
        path.fill()
        
        // path.stroke()
        // Close the path. This will create the last line automatically.
        path.close()
    }
}
