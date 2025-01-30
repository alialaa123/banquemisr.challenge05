//
//  ListOfMoviesView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 29/01/2025.
//

import SwiftUI

struct ListOfMoviesView: View {
    // MARK: - State property
    @StateObject var viewModel: ListOfMoviesViewModel
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AppMainHeaderView(headerTitle: "BanqueMisr Entertainment")
            
            ListSwitcherView(
                tabs: $viewModel.tabs,
                selectedTab: $viewModel.selectedTab
            )
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ListOfMoviesView(viewModel: ListOfMoviesViewModel())
}
