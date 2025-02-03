//
//  DefaultMovieDetailsDependencyContainer.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import SwiftUI
import Domain
import Data
import NetworkLayer

final class DefaultMovieDetailsDependencyContainer: MovieDetailsDependencyContainer {
    func makeMovieDetailsView(
        with movieId: Int,
        action: MovieDetailsAction
    ) -> UIHostingController<MovieDetailsView> {
        let viewModel = makeMovieDetailsViewModel(with: movieId, action: action)
        return UIHostingController(rootView: MovieDetailsView(viewModel: viewModel))
    }
    
    private func makeMovieDetailsViewModel(
        with movieId: Int,
        action: MovieDetailsAction
    ) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(
            movieId: movieId,
            movieDetailsUseCase: makeMovieDetailsUseCase(),
            movieDetailsAction: action
        )
    }
    
    private func makeMovieDetailsUseCase() -> GetMovieDetailsUseCase {
        DefaultGetMovieDetailsUseCase(repository: makeMovieDetailsRepository())
    }
    
    private func makeMovieDetailsRepository() -> MovieDetailsRepository {
        DefaultGetMovieDetailsRemote(client: APIClient(baseURL: AppConfig.baseURL))
    }
}
