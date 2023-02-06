//
//  CocktailsListBuilder.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import UIKit
enum CocktailsListBuilder {
    static func start() -> UIViewController {
        let view = CocktailsListViewController()
        let presenter = CocktailsListPresenter()
        let interactor = CocktailsListInteractor()
        let router = CocktailsListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
}
