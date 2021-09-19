//
//  WishListCell.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/7/21.
//  Copyright © 2021  All rights reserved.
//

import UIKit

class WishListCell: UITableViewCell {
    
    @IBOutlet weak var FoodName: UILabel!
    @IBOutlet weak var FoodDesc: UILabel!
    @IBOutlet weak var FoodPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(product: Product){
        self.FoodName.text = product.productName
        self.FoodDesc.text = product.productDescription
        self.FoodPrice.text = "\(product.productPrice)"
        
    }
    
}
