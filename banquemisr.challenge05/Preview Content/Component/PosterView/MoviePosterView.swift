//
//  MoviePosterView.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import SwiftUI

struct MoviePosterView: View {
    // MARK: - Properties
    var moviePoster: URL?
    var posterHeight: CGFloat = 160
    
    // MARK: - View
    var body: some View {
        AsyncImage(url: moviePoster) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: posterHeight)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: posterHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            default:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 30)
                    .frame(height: posterHeight)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}
