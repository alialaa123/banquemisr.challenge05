//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import Foundation
import Domain
import Combine

final class MovieDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var shouldDismiss: Bool = false
    @Published var shouldShowError: Bool = false
    @Published var errorMessage: String?
    @Published var movie: Movie?
    
    let movieDetailsAction: MovieDetailsAction
    
    /// UseCases
    var movieDetailsUseCase: GetMovieDetailsUseCase
    
    /// AnyCancellable
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    init(
        movieId: Int,
        movieDetailsUseCase: GetMovieDetailsUseCase,
        movieDetailsAction: MovieDetailsAction
    ) {
        self.movieDetailsUseCase = movieDetailsUseCase
        self.movieDetailsAction = movieDetailsAction
        getMovieDetails(with: movieId)
        observateScreenDismiss()
    }
    
    // MARK: - Methods
    func getMovieDetails(with movieId: Int) {
        shouldShowError = false
        Task {
            do {
                let movieDetails = try await movieDetailsUseCase.execute(with: movieId)
                await MainActor.run {
                    movie = movieDetails
                }
            } catch {
                shouldShowError = true
                errorMessage = error.localizedDescription
            }
        }
    }
}

// MARK: - Observations Method
extension MovieDetailsViewModel {
    func observateScreenDismiss() {
        $shouldDismiss
            .receive(on: RunLoop.main)
            .sink { [weak self] shouldDismiss in
                guard let self, shouldDismiss else { return }
                self.movieDetailsAction.dismiss()
            }
            .store(in: &cancellable)
    }
}
