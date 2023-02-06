//
//  CocktailsDetailViewModel.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import Foundation
struct CocktailsDetailViewModel {
    let title: String
    let description: String?
    let imageURL: String?
    
    init(cocktail: Cocktail) {
        self.title = cocktail.strDrink
        self.description = cocktail.strInstructions
        self.imageURL = cocktail.strDrinkThumb
    }
    
}
