//
//  MovieDetailsCoordinator.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import UIKit
import Domain

final class MovieDetailsCoordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let movieDetailsDependencyContainer: MovieDetailsDependencyContainer
    
    // MARK: - Life cycle
    init(
        navigationController: UINavigationController,
        movieDetailsDependencyContainer: MovieDetailsDependencyContainer
    ) {
        self.navigationController = navigationController
        self.movieDetailsDependencyContainer = movieDetailsDependencyContainer
    }
    
    // MARK: - Methods
    func start(with movie: Movie) {
        let rootView = movieDetailsDependencyContainer.makeMovieDetailsView(with: movie, action: self)
        navigationController.pushViewController(rootView, animated: true)
    }
}

// MARK: - Action Delegate
extension MovieDetailsCoordinator: MovieDetailsAction {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
