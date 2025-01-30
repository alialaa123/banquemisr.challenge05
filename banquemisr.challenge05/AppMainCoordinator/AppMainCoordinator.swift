//
//  AppMainCoordinator.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import UIKit
import SwiftUI

class AppMainCoordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController = UINavigationController()
    
    // Long-lived Properties
    private let window: UIWindow
    private let dependencyContainer: AppMainDependencyContainer
    
    // MARK: - Life cycle
    init(window: UIWindow, dependencyContainer: AppMainDependencyContainer) {
        self.window = window
        self.dependencyContainer = dependencyContainer
    }
    
    // MARK: - Methods
    func start() {
        let rootView = dependencyContainer.makeListOfMoviesView()
        navigationController.pushViewController(rootView, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
    }
}
