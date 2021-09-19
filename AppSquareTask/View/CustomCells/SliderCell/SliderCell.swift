//
//  SliderCell.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/8/21.
//  Copyright © 2021  All rights reserved.
//

import UIKit

class SliderCell: UICollectionViewCell {

    @IBOutlet weak var sliderImages : UIImageView!
    @IBOutlet weak var firstView : UIView!
    @IBOutlet weak var secondView : UIView!
    @IBOutlet weak var quntValue : UILabel!
    @IBOutlet weak var firstViewProductName : UILabel!
    @IBOutlet weak var firstViewProductDescription : UILabel!
    
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductDescription: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductSize: UILabel!
    
    
     var counter = 0 {
         didSet { quntValue.text = "\(counter)" }
       }
    var OrderNow :(() -> Void)?
    var AddtoCart :(() -> Void)?
    var callbackQunt :((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.secondView.isHidden = true
        // Initialization code
    }
    
    @IBAction func orderNowBtnPressed(_ sender : UIButton){
        OrderNow?()
    }

    @IBAction func addtoCartBtnPressed(_ sender : UIButton){
        AddtoCart?()
    }
    @IBAction func addQuntBtnPressed(_ sender : UIButton){
        counter += 1
        callbackQunt?(counter)
    }
    @IBAction func removeQuntBtnPressed(_ sender : UIButton){
        if counter > 0 { counter -= 1 }
        callbackQunt?(counter)
    }
    
   @objc func flip() {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews]

    UIView.transition(with: firstView, duration: 1, options: transitionOptions, animations: {
        self.firstView.isHidden = true
    })

    UIView.transition(with: secondView, duration: 1, options: transitionOptions, animations: {
        self.secondView.isHidden = false
    })
    }
    
    func configureCell(model: CartModel){
        self.sliderImages.image = UIImage(named: model.image ?? "")
        self.firstViewProductName.text = model.name
        self.firstViewProductDescription.text = model.description
        self.ProductName.text = model.name
        self.ProductPrice.text = "\(model.totalPrice)$"
        self.ProductDescription.text = model.description
        self.ProductSize.text = model.size
    }
}
