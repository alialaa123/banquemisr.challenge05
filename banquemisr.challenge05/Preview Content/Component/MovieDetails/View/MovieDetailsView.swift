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
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack(alignment: .top) {
                        MoviePosterView(
                            moviePoster: viewModel.movie?.getImageURL,
                            posterHeight: 600
                        )
                        
                        // Error view if found
                        if viewModel.shouldShowError {
                            ErrorMessageView(errorMessage: viewModel.errorMessage)
                                .padding(.top, 100)
                        }
                    }
                    if viewModel.movie != nil {
                        InformationView(
                            informationToShow: [
                                MovieInformationPresentationModel(
                                    iconImage: "popcorn",
                                    text: viewModel.movie?.movieTitle ?? ""
                                ),
                                MovieInformationPresentationModel(
                                    iconImage: "calendar.badge.clock",
                                    text: viewModel.movie?.releaseDate ?? ""
                                ),
                                MovieInformationPresentationModel(
                                    iconImage: "timer",
                                    text: viewModel.movie?.getMovieDuration ?? ""
                                ),
                                MovieInformationPresentationModel(
                                    iconImage: "list.bullet.clipboard",
                                    text: viewModel.movie?.getGenresString ?? ""
                                )
                            ]
                        )
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                    }
                    
                    Spacer()
                    
                }
                InternalHeaderView(buttonAction: $viewModel.shouldDismiss)
            }
        }
        .ignoresSafeArea(.all)
    }
}
