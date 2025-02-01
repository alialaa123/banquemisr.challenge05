//
//  MovieDetailsView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    // MARK: - Properties
    @StateObject var viewModel: MovieDetailsViewModel
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .top) {
                MoviePosterView(
                    moviePoster: viewModel.movie.getImageURL,
                    posterHeight: 600
                )
                
                InternalHeaderView(buttonAction: $viewModel.shouldDismiss)
            }
            
            bottomInformationContext
            
            Spacer()
        }
        .ignoresSafeArea(.all)
    }
    
    // MARK: - Bottom Information Context
    var bottomInformationContext: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            Image(systemName: "popcorn")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
            
            Text(viewModel.movie.movieTitle)
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding()
            Spacer()
        }
    }
}
