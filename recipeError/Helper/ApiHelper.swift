//
//  ApiHelper.swift
//  recipeError
//
//  Created by Ümit Sevim on 27.07.18.
//  Copyright © 2018 Ümit Sevim. All rights reserved.
//

import Alamofire
import Foundation

class APIHelper: NSObject {
    func getCategorys(completionHandler: @escaping ([Category]) -> Void) {
        let pageURL = URL(string: "https://demo.lightrecipe.co/api/category")
        
        Alamofire.request(pageURL!).responseJSON { (response) in
            switch response.result {
            case .success:
                var categoryArray = [Category]()
                let jsonData = response.data
                do {
                    let root = try JSONDecoder().decode([Category].self, from: jsonData!)
                    
                    categoryArray = root
                    
                } catch {
                    print("Error: \(error)")
                }
                DispatchQueue.main.async {
                    completionHandler(categoryArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRecipes(completionHandler: @escaping ([Recipe]) -> Void) {
        
        let pageURL = URL(string: "https://demo.lightrecipe.co/api/recipe/all")
        Alamofire.request(pageURL!).responseJSON { (response) in
            switch response.result {
            case .success:
                var recipeArray = [Recipe]()
                let jsonData = response.data
                do {
                    let root = try JSONDecoder().decode([Recipe].self, from: jsonData!)
                    recipeArray = root
                } catch {
                    print("Error: \(error)")
                }
                DispatchQueue.main.async {
                    completionHandler(recipeArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCategoryRecipes(catID: Int, completionHandler: @escaping ([Recipe]) -> Void) {
        let pageURL = URL(string: "https://demo.lightrecipe.co/api/recipe/category/\(catID)")
        
        Alamofire.request(pageURL!).responseJSON { (response) in
            switch response.result {
            case .success:
                var recipeArray = [Recipe]()
                let jsonData = response.data
                do {
                    let root = try JSONDecoder().decode([Recipe].self, from: jsonData!)
                    recipeArray = root
                } catch {
                    print("Error: \(error)")
                }
                DispatchQueue.main.async {
                    completionHandler(recipeArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
