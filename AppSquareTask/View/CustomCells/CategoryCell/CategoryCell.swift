//
//  CategoryCell.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/7/21.
//  Copyright © 2021  All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryName : UILabel!
    @IBOutlet weak var labelBackground : UIView!
    @IBOutlet weak var labelLine : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(model: CategoryModel){
        if model.isSelected == false {
            labelLine.isHidden = true
            labelBackground.backgroundColor = .white
        } else {
            labelLine.isHidden = false
            labelBackground.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.198630137)
        }
        categoryName.text = model.name
    }

}
