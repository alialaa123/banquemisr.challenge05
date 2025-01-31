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

class DefaultAppMainDependencyContainer: AppMainDependencyContainer {
    // MARK: - Methods
    func makeListOfMoviesView() -> UIHostingController<ListOfMoviesView> {
        let viewModel = makeListOfMoviesViewModel()
        let listOfMoviesView = ListOfMoviesView(viewModel: viewModel)
        return UIHostingController(rootView: listOfMoviesView)
    }
    
    private func makeListOfMoviesViewModel() -> ListOfMoviesViewModel {
        return ListOfMoviesViewModel(listOfMovieUseCase: makeListOfMoviesUseCase())
    }
    
    private func makeListOfMoviesUseCase() -> GetListOfMoviesUseCase {
        DefaultGetListOfMoviesUseCase(repository: makeListOfMoviesRepository())
    }
    
    private func makeListOfMoviesRepository() -> ListOfMoviesRepository {
        DefaultGetGoldenPinBookingRemote(client: APIClient(baseURL: "https://api.themoviedb.org/3/movie/"))
    }
}
