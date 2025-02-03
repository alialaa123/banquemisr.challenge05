//
//  AppMainCoordinator.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import UIKit
import SwiftUI
import Domain

final class AppMainCoordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController = UINavigationController()
    
    // Long-lived Properties
    private let window: UIWindow
    private let dependencyContainer: AppMainDependencyContainer
    private let tabBarController: UITabBarController
    
    // MARK: - Life cycle
    init(window: UIWindow, dependencyContainer: AppMainDependencyContainer) {
        self.window = window
        self.dependencyContainer = dependencyContainer
        self.tabBarController = dependencyContainer.tabBarController
    }
    
    // MARK: - Methods
    func start() {
        window.rootViewController = tabBarController
    }
}
