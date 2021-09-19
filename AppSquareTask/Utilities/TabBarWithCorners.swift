//
//  TabBarWithCorners.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/6/21.
//  Copyright © 2021 eramint.com. All rights reserved.
//
import UIKit

class TabBarWithCorners: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.clipsToBounds = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY + 5, width: tabBar.bounds.width - 60, height: tabBar.bounds.height + 10), cornerRadius: (tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
      
        tabBar.layer.insertSublayer(layer, at: 0)

        if let items = tabBar.items {
            items.forEach { item in
                item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
            }
        }

        tabBar.itemWidth = 30.0
        tabBar.itemPositioning = .fill
      }
    }
