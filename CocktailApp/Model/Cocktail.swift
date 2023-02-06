//
//  Cocktail.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import Foundation

struct CocktailsContainer: Codable {
    let drinks: [Cocktail]?
}

struct Cocktail: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String?
    let dateModified: String?
    let strTags: String?
    let strInstructions: String?
    let strImageSource: String?
}
