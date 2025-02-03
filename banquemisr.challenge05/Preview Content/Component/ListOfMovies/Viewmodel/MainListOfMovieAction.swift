//
//  MainListOfMovieAction.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import Foundation
import Domain

protocol MainListOfMovieAction: AnyObject {
    func showMovieDetails(for movieId: Int)
}
