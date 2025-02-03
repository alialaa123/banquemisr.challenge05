//
//  MovieDetailsRequest.swift
//  Data
//
//  Created by ali alaa on 03/02/2025.
//


import Foundation
import NetworkLayer
import Domain

struct MovieDetailsRequest: AuthenticateRequest, Retryable {
    typealias Response = MovieDTO
    
    var path: String
    var method: HTTPMethod { .get }
    var queryParameters: [String : String]? { nil }
    var authToken: String
    
    var maxRetries: Int = 2
    var retryDelay: TimeInterval = 2.0
}
