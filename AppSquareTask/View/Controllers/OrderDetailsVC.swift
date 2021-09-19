//
//  OrderDetailsVC.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/8/21.
//  Copyright © 2021  All rights reserved.
//

import UIKit

class OrderDetailsVC: UIViewController {

    @IBOutlet weak var sliderCV: UICollectionView!{
        didSet{
            sliderCV.backgroundColor = .clear
            sliderCV.isPagingEnabled = true
            sliderCV.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        }
    }
    private var products = CartViewModel.cartArr
       override func viewDidLoad() {
           super.viewDidLoad()
       }
       
       func saveToCart(index: Int){
           DataBaseCartManager.sharedDB.SaveToFav(model: products[index])
       }
  
    @IBAction func cartBtnPressed(_ sender: UIButton){
        self.poshWithoutData(identifire: "CartVC")
    }
}


extension OrderDetailsVC: UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
        //MARK:- ORDER NOW BTO TO FLIP THE SECOND VIEW
        cell.OrderNow = {
            cell.perform(#selector(cell.flip), with: nil, afterDelay: 0.5)
        }
        
        let product = products[indexPath.item]
        cell.configureCell(model: product)
        
        cell.callbackQunt = { newValue in
            self.products[indexPath.item].count = newValue
            cell.ProductPrice.text = "\(self.products[indexPath.item].totalPrice)$"
        }
        
        cell.AddtoCart = {
            self.saveToCart(index: indexPath.item)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
}

extension OrderDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

       let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)

        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset - 7, bottom: 0, right: rightInset - 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

