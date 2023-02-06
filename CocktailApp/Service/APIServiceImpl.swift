//
//  SearchService.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import Foundation

protocol APIService {
    init(networkService: NetworkService)
    func search(query: String, completionHandler: @escaping (Result<[Cocktail], NetworkResponseError>) -> Void)
    func lookup(cocktailId: String, completionHandler: @escaping (Result<[Cocktail], NetworkResponseError>) -> Void)
}

final class APIServiceImpl: APIService {
    private let networkService: NetworkService
    private let decoder = JSONDecoder()

    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }

    func search(query: String, completionHandler: @escaping (Result<[Cocktail], NetworkResponseError>) -> Void) {
        do {
            let request = try URLRequestBuilder.build(path: CocktailAPIPath.search.rawValue, params: ["s": query], httpMethod: .get)
            networkService.sendRequest(request: request) { result in
                switch result {
                case let .success(data):
                    completionHandler(self.handleCocktails(data: data))
                case let .failure(failure):
                    completionHandler(.failure(failure))
                }
            }
        } catch {
            completionHandler(.failure(error as? NetworkResponseError ?? .failed))
        }
    }

    func lookup(cocktailId: String, completionHandler: @escaping (Result<[Cocktail], NetworkResponseError>) -> Void) {
        do {
            let request = try URLRequestBuilder.build(path: CocktailAPIPath.lookup.rawValue, params: ["i": cocktailId], httpMethod: .get)
            networkService.sendRequest(request: request) { result in
                switch result {
                case let .success(data):
                    completionHandler(self.handleCocktails(data: data))
                case let .failure(failure):
                    completionHandler(.failure(failure))
                }
            }
        } catch {
            completionHandler(.failure(error as? NetworkResponseError ?? .failed))
        }
    }
}

extension APIServiceImpl {
    private func handleCocktails(data: Data) -> Result<[Cocktail], NetworkResponseError> {
        do {
            let cocktailsContainer = try decoder.decode(CocktailsContainer.self, from: data)
            if let cocktails = cocktailsContainer.drinks {
                return .success(cocktails)
            } else {
                return .failure(.noData)
            }

        } catch {
            return .failure(.unableToDecode)
        }
    }
}
