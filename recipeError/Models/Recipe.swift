//
//  Recipe.swift
//  recipeError
//
//  Created by Ümit Sevim on 27.07.18.
//  Copyright © 2018 Ümit Sevim. All rights reserved.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let cuisine_name: String
    let category_id: Int
    let category_name: String
    let name: String
    let description: String
    let preparation: String
    let preparation_time: Int
    let cooking_time: Int
    let person_quantity: Int
    let main_image: URL
    let images: [Image]?
    let video: URL?
    let ingredients: [Ingredient]
}

struct Image: Codable{
    
}

struct Ingredient: Codable {
    let ingredient_id: Int
    let name: String
    let quantity: String
}
