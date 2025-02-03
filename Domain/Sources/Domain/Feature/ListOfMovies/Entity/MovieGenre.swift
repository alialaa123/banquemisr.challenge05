//
//  MovieGenre.swift
//  Domain
//
//  Created by ali alaa on 03/02/2025.
//

import Foundation

public struct MovieGenre: Sendable, Hashable {
    // MARK: - Properties
    let id: Int
    let name: String
    
    // MARK: - Life cycle
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
