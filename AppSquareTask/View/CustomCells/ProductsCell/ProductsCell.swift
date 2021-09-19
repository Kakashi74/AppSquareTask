//
//  ProductsCell.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/7/21.
//  Copyright ©  All rights reserved.
//

import UIKit

class ProductsCell: UICollectionViewCell {

    @IBOutlet weak var ProductName : UILabel!
    @IBOutlet weak var ProductDescription : UILabel!
    @IBOutlet weak var ProductPrice : UILabel!
    @IBOutlet weak var isFavBtn : UIButton!
    @IBOutlet weak var image : UIImageView!
    
    var FavBtn : (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCell(product : ProductModel){
        if product.isFavourite {
             isFavBtn.setImage(UIImage(named: "heart"), for: .normal)
        }else {
            isFavBtn.setImage(UIImage(named: "like"), for: .normal)
        }
        self.image.image = UIImage(named: product.image ?? "")
        self.ProductName.text = product.name
        self.ProductDescription.text = product.description
        self.ProductPrice.text = "\(product.price!)"
    }
    @IBAction func FavBtnPressed(_ sender : Any){
        FavBtn?()
    }
}
