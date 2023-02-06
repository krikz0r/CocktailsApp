//
//  CocktailsListInteractor.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import Foundation

final class CocktailsListInteractor: CocktailsListPresenterToInteractorProtocol {

    
    
    //MARK: - Properties
    
    weak var presenter: CocktailsListInteractorToPresenterProtocol?
    private let apiService: APIService
    private var timer: Timer?
    private var query: String = ""
    
    //MARK: - Init
    
    init(apiService: APIService = APIServiceImpl()) {
        self.apiService = apiService
    }
    
    //MARK: - CocktailsListPresenterToInteractorProtocol

    func searchCocktails(query: String) {
        guard self.query != query else { return }
        self.query = query
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(search), userInfo: nil, repeats: false)
    }
    
    func cancelSearch() {
        timer?.invalidate()
    }
    
    func lookupCocktail(with id: String) {
        presenter?.startLoading()
        apiService.lookup(cocktailId: id) { [weak self] result in
            switch result {
            case .success(let cocktail):
                if let currentCocktail = cocktail.first {
                    self?.presenter?.didReceiveLookupCocktail(.success(currentCocktail))
                }
            case .failure(let error):self?.presenter?.didReceiveLookupCocktail(.failure(error))
            }
        }
    }

    @objc private func search() {
        presenter?.startLoading()
        apiService.search(query: query) { [weak self] result in
            self?.presenter?.didReceiveCocktails(result)
        }
    }
}
