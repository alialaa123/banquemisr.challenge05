//
//  MainListOfMoviesTypes.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 31/01/2025.
//

import Foundation

enum MainListOfMoviesTypes: String, CaseIterable {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case upcoming = "upcoming"
    
    // Description title for view
    var title: String {
           switch self {
           case .nowPlaying:
               return "Now_Playing"
           case .popular:
               return "Popular"
           case .upcoming:
               return "Upcoming"
           }
       }
}
