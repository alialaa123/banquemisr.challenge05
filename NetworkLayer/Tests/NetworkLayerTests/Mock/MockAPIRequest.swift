//
//  MockAPIRequest.swift
//  NetworkLayer
//
//  Created by ali alaa on 02/02/2025.
//

@testable import NetworkLayer

struct MockAPIRequest: APIRequest, Encodable {
    typealias Response = MockMovieResponse
    
    var path: String = "/test"
    var method: HTTPMethod = .get
    var headers: [String: String]? = nil
    var queryParameters: [String: String]? = nil
    
    // Manual implementation to make it confirm Encodable
    enum CodingKeys: String, CodingKey {
        case path, method, headers, queryParameters
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(path, forKey: .path)
        try container.encode(method.rawValue, forKey: .method)
        try container.encode(headers, forKey: .headers)
        try container.encode(queryParameters, forKey: .queryParameters)
    }
}
