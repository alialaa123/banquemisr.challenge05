//
//  ListOfMoviesView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 29/01/2025.
//

import SwiftUI
import Domain

struct ListOfMoviesView: View {
    // MARK: - State property
    @StateObject var viewModel: ListOfMoviesViewModel
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // App main header
            AppMainHeaderView(headerTitle: "BanqueMisr Entertainment")
            
            // Tab Switcher
            ListSwitcherView(
                selectedTab: $viewModel.selectedTab
            )
            
            // Grid of movies poster
            GridOfMoviesListView(
                listOfMovies: $viewModel.listOfMovies,
                movieSelected: $viewModel.movieSelected,
                loadNextPage: $viewModel.isLoadNextPage
            )
            
            // Error view if found
            if viewModel.shouldShowError {
                ErrorMessageView(errorMessage: viewModel.errorMessage)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .padding(.horizontal)
        .onReceive(viewModel.$selectedTab, perform: { newValue in
            viewModel.resetAndLoad()
        })
        .onAppear {
            Task {
                await viewModel.getListOfMovies()
            }
        }
    }
}
