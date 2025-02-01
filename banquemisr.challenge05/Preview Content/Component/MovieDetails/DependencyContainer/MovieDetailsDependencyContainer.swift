//
//  MovieDetailsDependencyContainer.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import SwiftUI
import Domain

protocol MovieDetailsDependencyContainer {
    func makeMovieDetailsView(
        with movie: Movie,
        action: MovieDetailsAction
    ) -> UIHostingController<MovieDetailsView>
}
