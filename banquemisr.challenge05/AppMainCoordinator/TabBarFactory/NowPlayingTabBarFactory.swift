//
//  NowPlayingTabBarFactory.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import UIKit

final class NowPlayingTabBarFactory: TabBarFactory {
    // MARK: - Properties
    var nowPlayingCoordinator: ListOfMoviesCoordinator?
    /// in production project, of course I will rely on constants for names not directly inject static name directly
    var tabBarImage: UIImage = UIImage(systemName: "film") ?? UIImage()
    var tabBarSelectedImage: UIImage = UIImage(systemName: "film.fill") ?? UIImage()
    var tabBarTitle = MainListOfMoviesTypes.nowPlaying.title
    
    // MARK: - Methods
    func makeTabBarView() -> UINavigationController {
        let navigationController = UINavigationController()
        nowPlayingCoordinator = ListOfMoviesCoordinator(
            navigationController: navigationController,
            dependencyContainer: makeNowPlayingDependencyContainer(),
            selectedTab: .nowPlaying
        )
        nowPlayingCoordinator?.start()
        return navigationController
    }
    
    /// For test purpose I add this functional to return type and not adding concrete type directly in MakeTabBarView func
    private func makeNowPlayingDependencyContainer() -> ListOfMoviesDependencyContainer {
        return DefaultListOfMoviesDependencyContainer()
    }
}
