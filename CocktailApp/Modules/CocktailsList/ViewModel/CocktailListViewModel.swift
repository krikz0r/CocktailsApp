//
//  CocktailListViewModel.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import Foundation
struct CocktailListViewModel {
    
    let title: String
    let tags: String?
    let description: String?
    let imageUrl: String?
    
    init(cocktail: Cocktail) {
        self.title = cocktail.strDrink
        self.tags = cocktail.strTags == nil ? nil : "Tags: \(cocktail.strTags ?? "")"
        self.description = cocktail.strInstructions
        self.imageUrl = cocktail.strDrinkThumb
    }
    
}
