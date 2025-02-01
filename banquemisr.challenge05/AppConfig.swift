//
//  AppConfig.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 01/02/2025.
//

import Foundation

struct AppConfig {
    static let baseURL: String = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let baseURL = dict["BaseURL"] as? String else {
            fatalError("Conf.plist is not found")
        }
        return baseURL
    }()
}
