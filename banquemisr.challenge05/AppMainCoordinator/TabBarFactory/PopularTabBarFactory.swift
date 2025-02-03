//
//  PopularTabBarFactory.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import UIKit

final class PopularTabBarFactory: TabBarFactory {
    // MARK: - Properties
    var nowPlayingCoordinator: ListOfMoviesCoordinator?
    var tabBarImage: UIImage = UIImage(systemName: "popcorn") ?? UIImage()
    var tabBarSelectedImage: UIImage = UIImage(systemName: "popcorn.fill") ?? UIImage()
    var tabBarTitle = MainListOfMoviesTypes.popular.title
    
    // MARK: - Methods
    func makeTabBarView() -> UINavigationController {
        let navigationController = UINavigationController()
        nowPlayingCoordinator = ListOfMoviesCoordinator(
            navigationController: navigationController,
            dependencyContainer: makeNowPlayingDependencyContainer(),
            selectedTab: .popular
        )
        nowPlayingCoordinator?.start()
        return navigationController
    }
    
    private func makeNowPlayingDependencyContainer() -> ListOfMoviesDependencyContainer {
        return DefaultListOfMoviesDependencyContainer()
    }
}
