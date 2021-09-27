//
//  HomeVC.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/7/21.
//  Copyright ©  All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var categortCV : UICollectionView!{
        didSet {
            categortCV.isScrollEnabled = false
            categortCV.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        }
    }
    @IBOutlet weak var ProductsCV: UICollectionView! {
        didSet {
            ProductsCV.register(UINib(nibName: "ProductsCell", bundle: nil), forCellWithReuseIdentifier: "ProductsCell")
        }
    }
    @IBOutlet weak var searchTextField : UITextField!
    @IBOutlet var allTextFields : [UITextField]!
    
    
    var home = HomeViewModel()
    var selectidIndex: Int = 0
    var searching:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        home.reloadCompl = {[weak self] in
            self?.categortCV.reloadData()
            self?.ProductsCV.reloadData()
        }
        home.loadCategories()
        searchTextField.delegate = self
        view.HideKeyboard()
    }
    
    @IBAction func searchBtnPressed(_ sender: Any){
        for textField in self.allTextFields where textField.text!.isEmpty {
            textField.shake()
            return
        }
    }
    
    @IBAction func cartBtnPressed(_ sender : UIButton){
        poshWithoutData(identifire: "CartVC") 
    }
}

extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.categortCV :
            return home.getCategoriesCount()
        case self.ProductsCV:
            if( searching == true){
                return home.searchArrRes.count
            } else {
                return home.getProductsCount()
            }
        default :
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.setData(model: home.categories[indexPath.item])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
        if( searching == true){
            cell.ConfigureCell(product: home.getProductAt(index: indexPath.item))
        } else {
            cell.ConfigureCell(product: home.getProductAt(index: indexPath.item))
            cell.FavBtn = {
                self.home.selectAt(index: indexPath.item)
            }
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            home.categories[selectidIndex].isSelected?.toggle()
            selectidIndex = indexPath.item
            home.categories[selectidIndex ].isSelected?.toggle()
            home.selctecProducstAt(index: indexPath.item)
        } else if collectionView.tag == 1 {
            poshWithoutData(identifire: "OrderDetailsVC") 
        }
    }
    
    
}



extension HomeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.categortCV :
            return CGSize(width: 90 , height: 40)
        case self.ProductsCV :
            return CGSize(width: 325 , height: 200)
        default :
            return CGSize(width: 35 , height: 35)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case self.categortCV :
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        case self.ProductsCV :
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        default :
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}


extension HomeVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        //input text
        let searchText  = textField.text! + string
        //add matching text to arrya
        home.searchArrRes = self.home.selectedCategoryProducts.filter({($0.name?.lowercased().contains(searchText.lowercased()) ?? true )})
        
        if(home.searchArrRes.count == 0){
            searching = false
        }else{
            searching = true
        }
        self.ProductsCV.reloadData()
        
        return true
    }
    
}


extension UITabBar {

static func setTransparentTabbar() {
  UITabBar.appearance().backgroundImage = UIImage()
  UITabBar.appearance().shadowImage     = UIImage()
  UITabBar.appearance().clipsToBounds   = true
 }
}
