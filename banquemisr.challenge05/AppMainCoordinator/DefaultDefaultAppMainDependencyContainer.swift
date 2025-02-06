//
//  DefaultDefaultAppMainDependencyContainer.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 30/01/2025.
//

import UIKit

final class DefaultAppMainDependencyContainer: AppMainDependencyContainer {
    // MARK: - Properties
    lazy var nowPlayingMovieFactory = NowPlayingTabBarFactory()
    lazy var popularMovieFactory = PopularTabBarFactory()
    lazy var upcomingMovieFactory = UpcomingTabBarFactory()
    
    var tabBarController: UITabBarController {
        let tabBar = DefaultTabBarFactory([
            nowPlayingMovieFactory,
            popularMovieFactory,
            upcomingMovieFactory
        ])
        return tabBar.makeTabBar()
    }
}
