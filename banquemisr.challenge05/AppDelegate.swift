//
//  AppDelegate.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 29/01/2025.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appMainCoordinator: AppMainCoordinator?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appMainDependencyContainer = DefaultAppMainDependencyContainer()
        
        appMainCoordinator = AppMainCoordinator(
            window: window,
            dependencyContainer: appMainDependencyContainer
        )
        
        appMainCoordinator?.start()
        window.makeKeyAndVisible()

        self.window = window
        return true
    }
}
