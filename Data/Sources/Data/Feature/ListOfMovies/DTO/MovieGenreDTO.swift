//
//  MovieGenreDTO.swift
//  Data
//
//  Created by ali alaa on 03/02/2025.
//

import Domain

public struct MovieGenreDTO: Decodable {
    // MARK: - Properties
    let id: Int
    let name: String
    
    // MARK: - Method
    public func toDomain() -> MovieGenre {
        .init(id: id, name: name)
    }
}
