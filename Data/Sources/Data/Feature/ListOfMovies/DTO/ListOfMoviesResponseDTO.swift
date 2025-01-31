//
//  ListOfMoviesResponseDTO.swift
//  Data
//
//  Created by ali alaa on 31/01/2025.
//

import Foundation

public struct ListOfMoviesResponseDTO: Decodable {
    public let page: Int
    public let results: [ListOfMoviesDTO]
}
