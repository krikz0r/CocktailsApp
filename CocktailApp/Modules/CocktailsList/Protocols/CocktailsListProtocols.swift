//
//  CocktailsListProtocols.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import UIKit


//MARK: - View -> Presenter

protocol CocktailsListViewToPresenterProtocol: AnyObject {
    var view: CocktailsListPresenterToViewProtocol? { get set }
    var interactor: CocktailsListPresenterToInteractorProtocol? { get set }
    var router: CocktailsListPresenterToRouterProtocol? { get set }
    
    func didEnterQuery(_ value: String)
    func numberOfRows() -> Int
    func getCurrentCocktail(at indexPath: IndexPath) -> CocktailListViewModel
    func didSelectCocktail(at indexPath: IndexPath)
}

//MARK: - Presenter ->  View

protocol CocktailsListPresenterToViewProtocol: AnyObject {
    var presenter: CocktailsListViewToPresenterProtocol? { get set }
    func startLoading()
    func stopLoading()
    func reloadData()
}

//MARK: - Interactor ->  Presenter

protocol CocktailsListInteractorToPresenterProtocol: AnyObject {
    func didReceiveCocktails(_ result: Result<[Cocktail],NetworkResponseError>)
    func startLoading()
    func didReceiveLookupCocktail(_ result: Result<Cocktail,NetworkResponseError>)
}

//MARK: - Presenter ->   Interactor

protocol CocktailsListPresenterToInteractorProtocol: AnyObject {
    init(apiService: APIService)
    var presenter: CocktailsListInteractorToPresenterProtocol? { get set }
    func searchCocktails(query: String)
    func cancelSearch()
    func lookupCocktail(with id: String)
}

//MARK: - Presenter ->   Router

protocol CocktailsListPresenterToRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showAlert(with message: String)
    func showDetail(with viewModel: CocktailsDetailViewModel)
}
