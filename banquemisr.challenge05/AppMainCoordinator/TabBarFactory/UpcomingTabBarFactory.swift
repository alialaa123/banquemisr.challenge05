//
//  UpcomingTabBarFactory.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 03/02/2025.
//

import UIKit

final class UpcomingTabBarFactory: TabBarFactory {
    // MARK: - Properties
    var nowPlayingCoordinator: ListOfMoviesCoordinator?
    var tabBarImage: UIImage = UIImage(systemName: "party.popper") ?? UIImage()
    var tabBarSelectedImage: UIImage = UIImage(systemName: "party.popper.fill") ?? UIImage()
    var tabBarTitle = MainListOfMoviesTypes.upcoming.title
    
    // MARK: - Methods
    func makeTabBarView() -> UINavigationController {
        let navigationController = UINavigationController()
        nowPlayingCoordinator = ListOfMoviesCoordinator(
            navigationController: navigationController,
            dependencyContainer: makeNowPlayingDependencyContainer(),
            selectedTab: .upcoming
        )
        nowPlayingCoordinator?.start()
        return navigationController
    }
    
    private func makeNowPlayingDependencyContainer() -> ListOfMoviesDependencyContainer {
        return DefaultListOfMoviesDependencyContainer()
    }
}
