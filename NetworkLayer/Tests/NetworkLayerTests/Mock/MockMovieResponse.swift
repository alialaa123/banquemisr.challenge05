//
//  MockMovieResponse.swift
//  NetworkLayer
//
//  Created by ali alaa on 02/02/2025.
//

import Foundation

struct MockMovieResponse: Decodable {
    let id: Int
    let movieTitle: String?
    let movieImage: String?
}
