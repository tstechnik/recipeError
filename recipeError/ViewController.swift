//
//  ViewController.swift
//  recipeError
//
//  Created by Ümit Sevim on 27.07.18.
//  Copyright © 2018 Ümit Sevim. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var apiHelper = APIHelper()
    var coreHelper = CoreHelper()
    var recipes =  [Recipe]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        apiHelper.getRecipes { (recipe) in
            self.recipes = recipe
        }
        
    }

    @IBAction func fetchFavoriten(_ sender: Any) {
        coreHelper.fetchRecipeIngredients(recipeID: 1)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addToFavorite(_ sender: Any) {
        coreHelper.addToFavorite(recipeItem: recipes[0])
    }
    
    @IBAction func fetchAllIngredients(_ sender: Any) {
        coreHelper.fetchAllIngredients()
    }
}

