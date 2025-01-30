//
//  ListOfMoviesViewModel.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import Foundation

class ListOfMoviesViewModel: ObservableObject {
    // MARK: - Properties
    @Published var tabs = ["Now Playing", "Popular", "Upcoming"]
    @Published var selectedTab: String = "Now Playing"
    
    // MARK: - Life cycle
    init() { }
    
    // MARK: - Methods
}
