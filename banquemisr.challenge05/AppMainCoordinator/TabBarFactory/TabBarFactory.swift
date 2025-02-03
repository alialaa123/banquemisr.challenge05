//
//  TabBarFactory.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import UIKit

protocol TabBarFactory: AnyObject {
    var tabBarImage: UIImage { get set }
    var tabBarSelectedImage: UIImage { get set }
    var tabBarTitle: String { get set }

    func makeTabBarView() -> UINavigationController
}
