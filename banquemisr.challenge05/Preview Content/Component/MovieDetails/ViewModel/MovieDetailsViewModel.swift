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
    let movie: Movie
    let movieDetailsAction: MovieDetailsAction
    
    /// AnyCancellable
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    init(movie: Movie, movieDetailsAction: MovieDetailsAction) {
        self.movie = movie
        self.movieDetailsAction = movieDetailsAction
        observateScreenDismiss()
    }
    
    // MARK: - Methods
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
