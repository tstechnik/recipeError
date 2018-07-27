//
//  CoreHelper.swift
//  recipeError
//
//  Created by Ümit Sevim on 27.07.18.
//  Copyright © 2018 Ümit Sevim. All rights reserved.
//

import UIKit
import CoreData

class CoreHelper: UIViewController {
    // MARK: - Favoriten
    func addToFavorite(recipeItem: Recipe) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let recipe = NSEntityDescription.entity(forEntityName: "CoreRecipe", in: managedContext)!
        let ingredient = NSEntityDescription.entity(forEntityName: "CoreIngredient", in: managedContext)!
        let recipeIngredient = NSEntityDescription.entity(forEntityName: "CoreRecipeIngredient", in: managedContext)!
        let newRecipeIngredient = CoreRecipeIngredient(entity:recipeIngredient, insertInto:managedContext)
        
        //let ingredient = NSEntityDescription.entity(forEntityName: "CoreIngredient", in: managedContext)!
        
        do {
            let item = CoreRecipe(entity: recipe, insertInto: managedContext)
            item.setValue(recipeItem.cooking_time, forKeyPath: "cooking_time")
            item.setValue(recipeItem.id, forKeyPath: "id")
            item.setValue(recipeItem.main_image, forKeyPath: "main_image")
            item.setValue(recipeItem.name, forKeyPath: "name")
            item.setValue(recipeItem.person_quantity, forKeyPath: "person_quantity")
            item.setValue(recipeItem.preparation, forKeyPath: "preparation")
            item.setValue(recipeItem.preparation_time, forKeyPath: "preparation_time")
            item.setValue(recipeItem.video, forKeyPath: "video")
            
            for ingredientItem in recipeItem.ingredients {
                let ingredient = CoreIngredient(entity: ingredient, insertInto: managedContext)
                ingredient.setValue(ingredientItem.ingredient_id, forKey: "ingredient_id")
                ingredient.setValue(ingredientItem.name, forKey: "name")
                newRecipeIngredient.setValue(ingredientItem.quantity, forKey: "quantity")
                
                newRecipeIngredient.recipe = item
                newRecipeIngredient.ingredient = ingredient
                newRecipeIngredient.quantity = ingredientItem.quantity
                
                try managedContext.save()
            }
            print("SAVED SUCCESSFULLY")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    // FETCH ALL FAVORITE RECIPE
    func fetchFavorite() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var recipes = [NSManagedObject]()
        let recipesRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreRecipe")
        
        do {
            recipes = try context.fetch(recipesRequest)
        }
        catch { print(error)
            
        }
        
        return recipes
    }
    
    func fetchRecipeIngredients(recipeID: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var ingredients = [NSManagedObject]()
        let request = NSFetchRequest<NSManagedObject>(entityName: "CoreIngredient")
        request.predicate = NSPredicate(format: "recipes.recipe.id = 1")
        
        do {
            ingredients = try context.fetch(request)
            print(ingredients.count)
            for ingredient in ingredients {
                print(ingredient.value(forKey: "name") as! String)
            }
        }
        catch { print(error)
        }
    }
    
    func fetchAllIngredients() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreIngredient")
        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                print(item.value(forKey: "name"))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
}
