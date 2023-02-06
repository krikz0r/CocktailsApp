//
//  URLRequestBuilder.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import Foundation

enum CocktailAPIPath: String {
    case search = "search.php"
    case lookup = "lookup.php"
}

enum URLRequestBuilder {
    enum URLBuilderError: Error {
        case badURL
        case systemError
    }

    static func build(path: String,
                      params: [String: String],
                      httpMethod: HTTPMethod
    ) throws -> URLRequest {
        let url = AppConstants.baseURL + path
        guard var urlComponents = URLComponents(string: url) else {
            throw URLBuilderError.badURL
        }
        urlComponents.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        guard let url = urlComponents.url else {
            throw URLBuilderError.systemError
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue.uppercased()
        return request
    }
}
