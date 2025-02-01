//
//  AppMainCoordinator.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import UIKit
import SwiftUI
import Domain

final class AppMainCoordinator: MainListOfMovieAction {
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
        let rootView = dependencyContainer.makeListOfMoviesView(with: self)
        navigationController.pushViewController(rootView, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
    }
    
    func showMovieDetails(for movie: Movie) {
        let movieDetailsCoordinator = dependencyContainer
            .makeMovieDetailDependencyContainer(with: navigationController)
        
        movieDetailsCoordinator.start(with: movie)
    }
}
