//
//  AppMainDependencyContainer.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import SwiftUI

protocol AppMainDependencyContainer {
    func makeListOfMoviesView(
        with confirmationAction: MainListOfMovieAction
    ) -> UIHostingController<ListOfMoviesView>
    
    func makeMovieDetailDependencyContainer(
        with navigationController: UINavigationController
    ) -> MovieDetailsCoordinator
        
}
