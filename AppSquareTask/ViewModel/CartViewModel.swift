//
//  CartViewModel.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/11/21.
//  Copyright © 2021  All rights reserved.
//

import Foundation

class CartViewModel{
    static var cartArr: [CartModel] = [
        CartModel(name: "Burger King", description: "Burger King With More Cheese", size: "L", image: "burger1",price: 25.0 ,count: 0, id: 1),
        CartModel(name: "Bufflo Burger", description: "Burger  With More Meat", size: "XL", image: "burger2", price: 30.0 ,count: 0, id:2),
        CartModel(name: "Atyab Burger", description: "Burger With more meat and cheese", size: "XXL", image: "burger3",price: 35.0 ,count: 0, id: 3)
    ]
}
