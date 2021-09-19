//
//  DataBaseCartManager.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/11/21.
//  Copyright © 2021  All rights reserved.
import Foundation
import CoreData
import UIKit


class DataBaseCartManager{
    static let sharedDB  = DataBaseCartManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cart = [Cart]()
    
    func SaveToFav(model: CartModel){
        
      //  let favRecipe = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
       
        var x = fetchCart()
        
        if x.contains(where: {$0.productID == "\( model.id!)"}){
            let item = x.first(where: {$0.productID == "\(model.id!)"})
            let cartCount = Int(item?.productQunt ?? "0") ?? 0
            let total = cartCount + 1
           
            item?.productQunt = "\(total)"
        }else{
            let favRecipe = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
            favRecipe.setValue(model.name ?? "" , forKey: "productName")
            favRecipe.setValue(model.description, forKey: "productDescription")
            favRecipe.setValue(model.price, forKey: "productPrice")
            favRecipe.setValue(model.totalPrice, forKey: "totalPrice")
            favRecipe.setValue("\(model.count ?? 0)", forKey: "productQunt")
            favRecipe.setValue("\(model.id ?? 0)", forKey: "productID")
        }
        
        
        
        
        
        
        
//
//        if !x.isEmpty {
//            for(index , val)  in x.enumerated() {
//
//                if (Int(val.productID ?? "") == model.id)
//                {
//                    let previusCount = Int(val.productQunt ?? "0")
//                   // remove(modelAt: model)
//                  //  x = fetchCart()
//                    let countt = "\((previusCount ?? 0) +  (model.count ?? 0))"
//                    x[index].productQunt = countt
//                    do{
//                    try? context.save()
//                    }
//                    return
////                    let favRecipe = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
////                    favRecipe.setValue(model.name ?? "" , forKey: "productName")
////                    favRecipe.setValue(model.description, forKey: "productDescription")
////                    favRecipe.setValue(model.totalPrice, forKey: "productPrice")
////                    favRecipe.setValue( countt , forKey: "productQunt")
////                    favRecipe.setValue("\(model.id ?? 0)", forKey: "productID")
//
//                    //     favRecipe.setValue(model.count, forKey: "productQunt")
//
//                } else {
//                   let favRecipe = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
//                    favRecipe.setValue(model.name ?? "" , forKey: "productName")
//                    favRecipe.setValue(model.description, forKey: "productDescription")
//                    favRecipe.setValue(model.totalPrice, forKey: "productPrice")
//                    favRecipe.setValue("\(model.count ?? 0)", forKey: "productQunt")
//                    favRecipe.setValue("\(model.id ?? 0)", forKey: "productID")
//                }
//            }
//
//        } else {
//            let favRecipe = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
//            favRecipe.setValue(model.name ?? "" , forKey: "productName")
//            favRecipe.setValue(model.description, forKey: "productDescription")
//            favRecipe.setValue(model.totalPrice, forKey: "productPrice")
//            favRecipe.setValue("\(model.count ?? 0)", forKey: "productQunt")
//            favRecipe.setValue("\(model.id ?? 0)", forKey: "productID")
//        }
//
         do{
            try context.save()
            AMToaster.toast("Saved To Cart")
        }catch{
            print("error")
        }
    }
    
    //MARK:- Fetch Core Data
    func fetchCart() -> [Cart]{
        do{
            return try context.fetch(Cart.fetchRequest()) as! [Cart]
        }catch{
            return []
        }
    }
    
    func remove( modelAt : CartModel){
        guard let modelId =  modelAt.id else {return}
        let cart = fetchCart()
        guard let item = cart.first(where: {$0.productID == "\(modelId)"}) else {return}
        context.delete(item)
        do
        {
            try context.save()
            AMToaster.toast("Removed From Cart")
        }
        catch{
            debugPrint("Error Could Not save\(error.localizedDescription)")
        }
    }
    
    
    
}
