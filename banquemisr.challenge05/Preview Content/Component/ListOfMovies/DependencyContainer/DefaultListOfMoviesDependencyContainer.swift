//
//  DefaultListOfMoviesDependencyContainer.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import SwiftUI
import Domain
import Data
import NetworkLayer

final class DefaultListOfMoviesDependencyContainer: ListOfMoviesDependencyContainer {
    // MARK: - Methods
    func makeListOfMoviesView(
        with confirmationAction: MainListOfMovieAction,
        for selectedTab: MainListOfMoviesTypes
    ) -> UIHostingController<ListOfMoviesView> {
        let viewModel = makeListOfMoviesViewModel(with: confirmationAction, for: selectedTab)
        let listOfMoviesView = ListOfMoviesView(viewModel: viewModel)
        return UIHostingController(rootView: listOfMoviesView)
    }
    
    private func makeListOfMoviesViewModel(
        with confirmationAction: MainListOfMovieAction,
        for selectedTab: MainListOfMoviesTypes
    ) -> ListOfMoviesViewModel {
        return ListOfMoviesViewModel(
            selectedTab: selectedTab,
            listOfMovieUseCase: makeListOfMoviesUseCase(),
            mainListOfMovieAction: confirmationAction
        )
    }
    
    private func makeListOfMoviesUseCase() -> GetListOfMoviesUseCase {
        DefaultGetListOfMoviesUseCase(
            repository: makeListOfMoviesRepository(),
            cachingRepository: makeMovieCachingRepository()
        )
    }
    
    private func makeListOfMoviesRepository() -> ListOfMoviesRepository {
        DefaultGetListOfMoviesRemote(client: APIClient(baseURL: AppConfig.baseURL))
    }
    
    private func makeMovieCachingRepository() -> GetListOfMoviesCachingRepository & InsertMoviesIntoCachingRepository {
        DefaultMovieCachingRepository()
    }
}

// MARK: - Movie Details screen
extension DefaultListOfMoviesDependencyContainer {
    func makeMovieDetailDependencyContainer(
        with navigationController: UINavigationController
    ) -> MovieDetailsCoordinator {
        MovieDetailsCoordinator(
            navigationController: navigationController,
            movieDetailsDependencyContainer: makeMovieDetailsDependencyContainer()
        )
    }
    
    private func makeMovieDetailsDependencyContainer() -> MovieDetailsDependencyContainer {
        DefaultMovieDetailsDependencyContainer()
    }
}
