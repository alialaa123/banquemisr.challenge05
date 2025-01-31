//
//  ListOfMoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import Foundation
import Domain

class ListOfMoviesViewModel: ObservableObject {
    // MARK: - Properties
    /// Publishers
    @Published var selectedTab: MainListOfMoviesTypes = .nowPlaying
    @Published var listOfMovies: [ListOfMovies]?
    @Published var errorMessage: String?
    @Published var shouldShowError: Bool = false
    @Published var isLoading: Bool = false
    @Published var currentPage = 1
    
    /// UseCases
    var listOfMovieUseCase: GetListOfMoviesUseCase
    
    // MARK: - Life cycle
    init(listOfMovieUseCase: GetListOfMoviesUseCase) {
        self.listOfMovieUseCase = listOfMovieUseCase
    }
    
    // MARK: - Methods
    @MainActor
    func getListOfMovies() async {
        guard !isLoading else { return }
        isLoading = true
        do {
            let movies = try await listOfMovieUseCase.execute(with: selectedTab.rawValue, page: currentPage)
            if listOfMovies == nil {
                listOfMovies = movies
            } else {
                /// this approach based on that maybe an duplication in movies on different pages
                /// which will lead to not crashing as listOfMovies is Hashable & Equatable
                /// but it will lead to show and empty space in view as the duplicate item will not load in view
                /// so I take this approach of NSOrderedSet as Set so items wont be duplicate and also ordered not losing the order of items
                let allMovies = (listOfMovies ?? []) + movies
                let nonDuplicatesMovies = NSOrderedSet(array: allMovies).array as? [ListOfMovies]
                listOfMovies = nonDuplicatesMovies
            }
        } catch {
            shouldShowError = true
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func loadNextPage() {
        currentPage += 1
        Task {
            await getListOfMovies()
        }
    }
    
    func resetAndLoad() {
        reset()
        Task {
            await getListOfMovies()
        }
    }
    
    private func reset() {
        currentPage = 1
        listOfMovies = nil
        shouldShowError = false
        errorMessage = nil
    }
}
