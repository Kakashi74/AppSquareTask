//
//  HomeViewModel.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/7/21.
//  Copyright © 2021  All rights reserved.
//

import Foundation
class HomeViewModel {
    var searchArrRes = [ProductModel]()
    
    var reloadCompl :(()->())?
    var categories = [CategoryModel](){
        didSet{
            self.reloadCompl?()
        }
    }
    var selectedCategoryProducts = [ProductModel](){
        didSet{
            self.reloadCompl?()
        }
    }
    func loadCategories(){
        categories = [CategoryModel(name: "Burger", isSelected: true, products:
            [ProductModel(name: "Bufflo Burger", price: 20.0, description: "Burger with more cheese",isFavourite: false, image:"burger1") ,
             ProductModel(name: "Heart Attack Burger", price: 30.0, description : "Burger with gold onions",isFavourite: false,image: "burger2" ) ,
             ProductModel(name: "KFC Burger", price: 25.0,description: "Burger with more meat" ,isFavourite: false , image: "burger3")])
            ,
                      
                      CategoryModel(name: "Pizza", isSelected: false, products:
                        [ProductModel(name: "Pizza Hat", price: 50.0,description:"Pizza chrimp" , isFavourite: false, image: "pizza1") ,
                         ProductModel(name: "PaPa Jones Pizza", price: 55.0, description: "Vegetables Pizza",isFavourite: false, image: "pizza2")
                      ])
            ,
                      CategoryModel(name: "Pasta", isSelected: false, products: []) ,
                      CategoryModel(name: "Salad", isSelected: false, products: [])]
        selectedCategoryProducts = categories.first?.products ?? []
        
    }
    func getCategoriesCount()-> Int{
        return categories.count
    }
    func getProductAt(index:Int)-> ProductModel{
        return selectedCategoryProducts[index]
    }
    func getProductsCount()->Int{
        return selectedCategoryProducts.count
    }
    func selctecProducstAt(index:Int){
        selectedCategoryProducts = categories[index].products ?? []
    }
    
    func selectAt(index: Int){
        selectedCategoryProducts[index].isFavourite.toggle()
        if selectedCategoryProducts[index].isFavourite {
            //MARK:- Save To Core
            DataBaseManegar.sharedDB.SaveToFav(model: selectedCategoryProducts[index])
        } else {
            //MARK:-  Delete From Core
            DataBaseManegar.sharedDB.remove(modelAt: selectedCategoryProducts[index])
        }
    }
    
    func getCategoriesAt(index: Int) -> CategoryModel{
        return categories[index]
    }
}
