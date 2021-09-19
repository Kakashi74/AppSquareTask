//
//  CartCell.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/8/21.
//  Copyright © 2021 All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak var ProductName : UILabel!
    @IBOutlet weak var ProductDescription : UILabel!
    @IBOutlet weak var ProductPrice : UILabel!
    @IBOutlet weak var ProductQunt : UILabel!
    
    var callbackQunt :((Int) -> Void)?
    var counter = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func addQuntBtnPressed(_ sender : Any){
        counter += 1
        callbackQunt?(counter)
    }
    @IBAction func removeQuntBtnPressed(_ sender : Any){
        if counter > 0 { counter -= 1 }
        callbackQunt?(counter)
    }
    
    func configureCell(cart: Cart){
        self.ProductName.text = cart.productName
        self.ProductDescription.text = cart.productDescription
        let price = cart.productPrice
        let count = Double(cart.productQunt!)
        self.ProductPrice.text = "\(price * (count ?? 0))$"
        self.ProductQunt.text = "\(cart.productQunt ?? "")"
    }
    
}
