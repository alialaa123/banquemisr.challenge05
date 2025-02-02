//
//  ListOfMoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import Foundation
import Domain
import Data
import Combine

final class ListOfMoviesViewModel: ObservableObject {
    // MARK: - Properties
    /// Publishers
    @Published var selectedTab: MainListOfMoviesTypes = .nowPlaying
    @Published var listOfMovies: [Movie]?
    @Published var movieSelected: Movie?
    
    @Published var errorMessage: String?
    @Published var shouldShowError: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var isLoadNextPage: Bool = false
    @Published var currentPage = 1
    
    /// Actions
    let mainListOfMovieAction: MainListOfMovieAction
    
    /// UseCases
    var listOfMovieUseCase: GetListOfMoviesUseCase
    
    /// Persistent Data
    let movieCachedRepository: MovieCachingRepository
    
    /// AnyCancellable
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    init(
        listOfMovieUseCase: GetListOfMoviesUseCase,
        mainListOfMovieAction: MainListOfMovieAction,
        movieCachedRepository: MovieCachingRepository
    ) {
        self.listOfMovieUseCase = listOfMovieUseCase
        self.mainListOfMovieAction = mainListOfMovieAction
        self.movieCachedRepository = movieCachedRepository
        loadCachedMovies()
        /// For Observe changes and do action through
        /// Using Combine better than go to Closure approach on the view to get the changes
        observeMovieSelection()
        observeLoadingNextPage()
        observeListTypeChange()
    }
    
    // MARK: - Methods
    func loadCachedMovies() {
        Task {
            do {
                let movies = try await movieCachedRepository.fetchMovies()
                await MainActor.run {
                    listOfMovies = movies
                }
            } catch {
                await getListOfMovies()
            }
        }
    }
    
    @MainActor
    func getListOfMovies() async {
        guard !isLoading else { return }
        isLoading = true
        do {
            let movies = try await listOfMovieUseCase.execute(with: selectedTab.rawValue, page: currentPage)
            
            /// I Put this limitation so it only cache first page & now_play only
            /// other that I will need to dedicate duplicate movies in the caching so the list keep clean with no duplication
            if selectedTab == .nowPlaying && currentPage == 1 {
                try await movieCachedRepository.insertMovies(movies: movies)
            }
            
            if listOfMovies == nil {
                listOfMovies = movies
            } else {
                /// this approach based on that maybe an duplication in movies on different pages
                /// which will lead to not crashing as listOfMovies is Hashable & Equatable
                /// but it will lead to show and empty space in view as the duplicate item will not load in view
                /// so I take this approach of NSOrderedSet as Set so items wont be duplicate and also ordered not losing the order of items
                let allMovies = (listOfMovies ?? []) + movies
                let nonDuplicatesMovies = NSOrderedSet(array: allMovies).array as? [Movie]
                listOfMovies = nonDuplicatesMovies
            }
        } catch {
            shouldShowError = true
            errorMessage = error.localizedDescription
            if listOfMovies == nil {
                do {
                    listOfMovies = try await movieCachedRepository.fetchMovies()
                } catch {
                    shouldShowError = true
                    errorMessage = error.localizedDescription
                }
            }
        }
        isLoading = false
    }
    
    func loadNextPage() {
        currentPage += 1
        shouldShowError = false
        errorMessage = nil
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

// MARK: - Observation Methods
extension ListOfMoviesViewModel {
    // For observe load Next Page of movies
    func observeLoadingNextPage() {
        $isLoadNextPage
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoadNextPage in
                guard let self, isLoadNextPage else { return }
                self.loadNextPage()
            }
            .store(in: &cancellable)
    }
    
    // For observe select of movie and navigate to Movie Details
    func observeMovieSelection() {
        $movieSelected
            .receive(on: RunLoop.main)
            .sink { [weak self] movieSelected in
                guard let self, let movieSelected else { return }
                mainListOfMovieAction.showMovieDetails(for: movieSelected)
            }
            .store(in: &cancellable)
    }
    
    func observeListTypeChange() {
        $selectedTab
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedTab in
                guard let self else { return }
                self.resetAndLoad()
            }
            .store(in: &cancellable)
    }
}
