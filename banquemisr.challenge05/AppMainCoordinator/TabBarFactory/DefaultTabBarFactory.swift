//
//  DefaultTabBarFactory.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import UIKit

final class DefaultTabBarFactory {
    // MARK: - Properties
    var viewControllers: [TabBarFactory]
    
    // MARK: - Life cycle
    init(_ viewControllers: [TabBarFactory]) {
        self.viewControllers = viewControllers
    }
    
    // MARK: - Methods
    private func configurationTabBarAppearance(tabBar: UITabBar) {
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(.white)
        tabBar.backgroundColor = UIColor(.white)
        tabBar.tintColor = UIColor(.black)
        tabBar.unselectedItemTintColor = UIColor(.gray)
    }
    
    public func makeTabBar() -> UITabBarController {
        let rootViewController = UITabBarController()
        rootViewController.setViewControllers(
            viewControllers.map { $0.makeTabBarView()
            },
            animated: false
        )
        
        configurationTabBarAppearance(tabBar: rootViewController.tabBar)
        
        viewControllers.enumerated().forEach { index, viewController in
            rootViewController.viewControllers?[index].tabBarItem.title = viewController.tabBarTitle
            rootViewController.viewControllers?[index].tabBarItem.image = viewController.tabBarImage
            rootViewController.viewControllers?[index].tabBarItem.selectedImage = viewController.tabBarSelectedImage
        }
        
        return rootViewController
    }
}
