//
//  ConfigHelper.swift
//  Domain
//
//  Created by ali alaa on 01/02/2025.
//

import Foundation

struct ConfigHelper {
    static let imageBaseURL: String = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let imageBaseURL = dict["ImageBaseURL"] as? String else {
            fatalError("Conf.plist is not found")
        }
        return imageBaseURL
    }()
}
