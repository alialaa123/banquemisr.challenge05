//
//  NowPlayingCoordinator.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import UIKit
import SwiftUI
import Domain

final class ListOfMoviesCoordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController?
    private let dependencyContainer: ListOfMoviesDependencyContainer
    private let selectedTab: MainListOfMoviesTypes
    
    // MARK: - Life cycle
    init(
        navigationController: UINavigationController?,
        dependencyContainer: ListOfMoviesDependencyContainer,
        selectedTab: MainListOfMoviesTypes
    ) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
        self.selectedTab = selectedTab
    }
    
    // MARK: - Methods
    func start() {
        let rootView = dependencyContainer.makeListOfMoviesView(
            with: self,
            for: selectedTab
        )
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(rootView, animated: false)
    }
}

// MARK: - Delegate Action
extension ListOfMoviesCoordinator: MainListOfMovieAction {
    func showMovieDetails(for movie: Movie) {
        guard let navigationController else { return }
        let movieDetailsCoordinator = dependencyContainer
            .makeMovieDetailDependencyContainer(with: navigationController)
        
        movieDetailsCoordinator.start(with: movie)
    }
}
