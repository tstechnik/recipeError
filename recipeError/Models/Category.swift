//
//  Category.swift
//  recipeError
//
//  Created by Ümit Sevim on 27.07.18.
//  Copyright © 2018 Ümit Sevim. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int
    let background: URL?
    let name: String
    let sort_order: Int!
}


