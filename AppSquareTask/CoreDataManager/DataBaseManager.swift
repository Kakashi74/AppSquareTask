//
//  DataBaseManager.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/9/21.
//  Copyright © 2021 eramint.com. All rights reserved.
import Foundation
import CoreData
import UIKit


class DataBaseManegar{
    static let sharedDB  = DataBaseManegar()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favRecipe = [Product]()
    //MARK:- Save To Core Data
    func SaveToFav(model: ProductModel ){
        
        if fetchFavRecipes().contains(where: {$0.productName == model.name})  {
             AMToaster.toast("Product already added To Favourite")
            return
        }
           let favRecipe = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)
        favRecipe.setValue(model.name ?? "" , forKey: "productName")
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
        guard let modelId =  modelAt.name else {return}
        let Favoitems = fetchFavRecipes()
        guard let item = Favoitems.first(where: {$0.productName == modelId}) else {return}
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
    func fetchFavRecipes() -> [Product]{
           do{
            return try context.fetch(Product.fetchRequest()) as! [Product]
           }catch{
               return []
           }
       }
}
