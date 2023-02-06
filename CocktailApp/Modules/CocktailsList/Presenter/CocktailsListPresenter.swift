//
//  CocktailsListPresenter.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import Foundation

final class CocktailsListPresenter: CocktailsListViewToPresenterProtocol {
    // MARK: - Properties

    weak var view: CocktailsListPresenterToViewProtocol?
    var interactor: CocktailsListPresenterToInteractorProtocol?
    var router: CocktailsListPresenterToRouterProtocol?
    private var cocktails: [Cocktail] = [Cocktail]() {
        didSet {
            view?.reloadData()
        }
    }

    // MARK: - CocktailsListViewToPresenterProtocol

    func didEnterQuery(_ value: String) {
        guard value.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3 else {
            interactor?.cancelSearch()
            cocktails = []
            return
        }
        interactor?.searchCocktails(query: value)
    }

    func numberOfRows() -> Int {
        return cocktails.count
    }

    func getCurrentCocktail(at indexPath: IndexPath) -> CocktailListViewModel {
        return CocktailListViewModel(cocktail: cocktails[indexPath.row])
    }

    func didSelectCocktail(at indexPath: IndexPath) {
        let cocktailId = cocktails[indexPath.row].idDrink
        view?.stopLoading()
        interactor?.lookupCocktail(with: cocktailId)
    }
}

// MARK: - CocktailsListInteractorToPresenterProtocol

extension CocktailsListPresenter: CocktailsListInteractorToPresenterProtocol {
    func didReceiveCocktails(_ result: Result<[Cocktail], NetworkResponseError>) {
        view?.stopLoading()
        switch result {
        case let .success(cocktails): self.cocktails = cocktails
        case let .failure(error): router?.showAlert(with: error.rawValue)
        }
    }

    func startLoading() {
        view?.startLoading()
    }
    
    func didReceiveLookupCocktail(_ result: Result<Cocktail, NetworkResponseError>) {
        view?.stopLoading()
        switch result {
        case .success(let cocktail): router?.showDetail(with: .init(cocktail: cocktail))
        case .failure(let error): router?.showAlert(with: error.rawValue)
        }
    }
}
