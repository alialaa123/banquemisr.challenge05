//
//  File.swift
//  Data
//
//  Created by ali alaa on 02/02/2025.
//

import CoreData
import Domain

/// Maps the object from `Movie` to `MovieEntity` .
extension MovieEntity {
    func toManagedObject(context: Movie) -> MovieEntity {
        let entity: MovieEntity = self
        entity.id = Int32(context.id)
        entity.movieTitle = context.movieTitle
        entity.movieImage = context.movieImage
        return entity
    }
    
    func toMovieDTO() -> MovieDTO {
        return .init(
            id: Int(id),
            movieTitle: movieTitle,
            movieImage: movieImage
        )
    }
}
