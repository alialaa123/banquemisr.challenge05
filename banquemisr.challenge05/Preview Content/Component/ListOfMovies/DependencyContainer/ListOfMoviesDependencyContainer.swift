//
//  ListOfMoviesDependencyContainer.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import SwiftUI

protocol ListOfMoviesDependencyContainer {
    func makeListOfMoviesView(
        with confirmationAction: MainListOfMovieAction,
        for selectedTab: MainListOfMoviesTypes
    ) -> UIHostingController<ListOfMoviesView>
    
    func makeMovieDetailDependencyContainer(
        with navigationController: UINavigationController
    ) -> MovieDetailsCoordinator
}
