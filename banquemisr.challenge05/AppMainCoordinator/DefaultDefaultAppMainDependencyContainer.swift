//
//  DefaultDefaultAppMainDependencyContainer.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import SwiftUI
import Domain
import Data
import NetworkLayer

final class DefaultAppMainDependencyContainer: AppMainDependencyContainer {
    // MARK: - Methods
    func makeListOfMoviesView(
        with confirmationAction: MainListOfMovieAction
    ) -> UIHostingController<ListOfMoviesView> {
        let viewModel = makeListOfMoviesViewModel(with: confirmationAction)
        let listOfMoviesView = ListOfMoviesView(viewModel: viewModel)
        return UIHostingController(rootView: listOfMoviesView)
    }
    
    private func makeListOfMoviesViewModel(with confirmationAction: MainListOfMovieAction) -> ListOfMoviesViewModel {
        return ListOfMoviesViewModel(
            listOfMovieUseCase: makeListOfMoviesUseCase(),
            mainListOfMovieAction: confirmationAction,
            movieCachedRepository: makeMovieCachingRepository()
        )
    }
    
    private func makeListOfMoviesUseCase() -> GetListOfMoviesUseCase {
        DefaultGetListOfMoviesUseCase(repository: makeListOfMoviesRepository())
    }
    
    private func makeListOfMoviesRepository() -> ListOfMoviesRepository {
        DefaultGetGoldenPinBookingRemote(client: APIClient(baseURL: AppConfig.baseURL))
    }
    
    private func makeMovieCachingRepository() -> MovieCachingRepository {
        DefaultMovieCachingRepository()
    }
}
// MARK: - Movie Details screen
extension DefaultAppMainDependencyContainer {
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
