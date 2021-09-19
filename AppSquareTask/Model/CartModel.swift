//
//  CartModel.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/11/21.
//  Copyright © 2021  All rights reserved.
//

import Foundation

struct CartModel {
    var name: String?
    var description : String?
    var size : String?
    var image : String?
    var price : Double?
    var count : Int?
    var id: Int?
    
    var totalPrice: Double {
        (price ?? 0) * Double(count ?? 1)
    }
}
