//
//  DataBaseManager.swift
//
//
//  Created by Ahmed on 9/9/21.
//  Copyright © 2021  All rights reserved.
import Foundation
import CoreData
import UIKit


class DataBaseManegar{
    static let sharedDB  = DataBaseManegar()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favRecipe = [Products]()
    //MARK:- Save To Core Data
    func SaveToFav(model: ProductModel ){
        
        if fetchFavRecipes().contains(where: {$0.productTitle == model.title})  {
             AMToaster.toast("Product already added To Favourite")
            return
        }
           let favRecipe = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context)
        favRecipe.setValue(model.title ?? ""  , forKey: "productTitle")
        favRecipe.setValue(model.price, forKey: "productPrice")
        favRecipe.setValue(model.description, forKey: "productDescription")
           do{
               try context.save()
            AMToaster.toast("Saved To Favourite")
           }catch{
               print("error")
           }
       }
    //MARK:- Remove From Core Data
    func remove( modelAt : ProductModel){
        guard let modelId =  modelAt.title else {return}
        let Favoitems = fetchFavRecipes()
        guard let item = Favoitems.first(where: {$0.productTitle == modelId}) else {return}
        context.delete(item)
        do
        {
            try context.save()
            AMToaster.toast("Removed From Favourite")
        }
        catch{
            debugPrint("Error Could Not save\(error.localizedDescription)")
        }
    }
    //MARK:- Fetch Core Data
    func fetchFavRecipes() -> [Products]{
           do{
            return try context.fetch(Products.fetchRequest()) as! [Products]
           }catch{
               return []
           }
       }
}
