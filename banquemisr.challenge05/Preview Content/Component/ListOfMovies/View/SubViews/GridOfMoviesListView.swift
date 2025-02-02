//
//  GridOfMoviesListView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import SwiftUI
import Domain

struct GridOfMoviesListView: View {
    // MARK: - Properties
    @Binding var listOfMovies: [Movie]?
    @Binding var movieSelected: Movie?
    let gridItems = Array(repeating: GridItem(.flexible(minimum: 30)), count: 3)
    @Binding var loadNextPage: Bool
    
    // MARK: - View
    var body: some View {
        if let listOfMovies {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: gridItems, spacing: 12) {
                    ForEach(Array(listOfMovies.enumerated()), id: \.offset) { index, movie in
                        MoviePosterView(moviePoster: movie.getImageURL)
                            .onTapGesture {
                                movieSelected = movie
                            }
                            .onAppear {
                                if index == listOfMovies.count - 1 {
                                    loadNextPage = true
                                }
                            }
                    }
                }
            }
        }
    }
}
