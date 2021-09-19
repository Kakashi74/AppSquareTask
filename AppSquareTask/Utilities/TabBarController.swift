//
//  TabBarController.swift
//  TabBarDemo
//
//  Created by Amr Mohamed on 10/19/20.
//

import UIKit

class TabBarController: UITabBarController {
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupBackgroundView()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = #colorLiteral(red: 0.3019607843, green: 0.7254901961, blue: 0.7764705882, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        tabBar.layer.cornerRadius = 30
        tabBar.layer.masksToBounds = true
//        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.items?.forEach({ item in
            item.imageInsets = .init(top: 12, left: 0, bottom: 0, right: 0)
            item.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)
        })
    }
    
    private func setupBackgroundView() {
        tabBar.insertSubview(backgroundView, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 5),
            backgroundView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 5),
            backgroundView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -5),
            backgroundView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: -5),
        ])
    }
}
