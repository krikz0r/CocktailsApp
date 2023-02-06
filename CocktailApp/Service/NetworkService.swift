//
//  NetworkService.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import Foundation

protocol NetworkService {
    func sendRequest(request: URLRequest, completion: @escaping ((Result<Data, NetworkResponseError>) -> Void))
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkResponseError: String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum NetworkResult {
    case success
    case failure(NetworkResponseError)
}

final class NetworkServiceImpl: NetworkService {
    func sendRequest(request: URLRequest, completion: @escaping ((Result<Data, NetworkResponseError>) -> Void)) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.failed))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    completion(.success(data))

                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResult {
        switch response.statusCode {
        case 200 ... 299: return .success
        case 401 ... 500: return .failure(NetworkResponseError.authenticationError)
        case 501 ... 599: return .failure(NetworkResponseError.badRequest)
        case 600: return .failure(NetworkResponseError.outdated)
        default: return .failure(NetworkResponseError.failed)
        }
    }
}
