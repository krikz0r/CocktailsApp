//
//  CocktailsListRouter.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import UIKit

final class CocktailsListRouter : CocktailsListPresenterToRouterProtocol {
    //MARK: - Properties

     var viewController: UIViewController?
    
    //MARK: - CocktailsListPresenterToRouterProtocol

    func showAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self.viewController?.present(alert, animated: true)
        }
       
    }
    
    func showDetail(with viewModel: CocktailsDetailViewModel) {
       
        DispatchQueue.main.async {
            let vc = CocktailsDetailViewController(viewModel: viewModel)
            self.viewController?.present(vc, animated: true)
        }
        
    }
}
