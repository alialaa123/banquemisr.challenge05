//
//  DefaultDefaultAppMainDependencyContainer.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import SwiftUI

class DefaultAppMainDependencyContainer: AppMainDependencyContainer {
    // MARK: - Methods
    func makeListOfMoviesView() -> UIHostingController<ListOfMoviesView> {
        let viewModel = makeListOfMoviesViewModel()
        let listOfMoviesView = ListOfMoviesView(viewModel: viewModel)
        return UIHostingController(rootView: listOfMoviesView)
    }
    
    private func makeListOfMoviesViewModel() -> ListOfMoviesViewModel {
        return ListOfMoviesViewModel()
    }
}
