//
//  CategoryModel.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/7/21.
//  Copyright © 2021  All rights reserved.
//

import Foundation

struct CategoryModel : Codable {
    let name : String?
    var isSelected : Bool?
    let products : [ProductModel]?
}

struct ProductModel : Codable {
    var name : String?
    var price : Double?
    var description : String?
    var isFavourite : Bool
    var image : String?
}

