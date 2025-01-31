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
    @Binding var listOfMovies: [ListOfMovies]?
    let gridItems = Array(repeating: GridItem(.flexible(minimum: 80)), count: 3)
    let loadNextPage: () -> Void
    
    // MARK: - View
    var body: some View {
        if let listOfMovies {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: gridItems, spacing: 12) {
                    ForEach(Array(listOfMovies.enumerated()), id: \.element.id) { index, movie in
                        MoviePosterView(moviePoster: movie.getImageURL)
                            .onAppear {
                                if index == listOfMovies.count - 1 {
                                    loadNextPage()
                                }
                            }
                    }
                }
            }
        }
    }
}
