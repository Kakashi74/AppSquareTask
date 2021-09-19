//
//  CartVC.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/8/21.
//  Copyright © 2021  All rights reserved.
//

import UIKit

class CartVC: UIViewController {
    
    @IBOutlet weak var cartTblView : UITableView!{
        didSet{
            cartTblView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
            cartTblView.separatorStyle = .none
        }
    }
    @IBOutlet weak var totalPriceLabel : UILabel!
    
    var cart  = [Cart](){
        didSet{
            cartTblView.reloadData()
        }
    }
    private var products = CartViewModel.cartArr
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cart = DataBaseCartManager.sharedDB.fetchCart()
        totalPriceLabel.text = "\(cart.map({$0.totalPrice}).reduce(0, +))$"
       
    }
    
    func deleteFromCart(index: Int) {
        DataBaseCartManager.sharedDB.remove(modelAt: products[index])
    }
    
    @IBAction func dismissBtn(_ sender: UIButton){
        self.popVC()
    }
}

extension CartVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTblView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
         let item = cart[indexPath.item]
        cell.configureCell(cart: item)
        cell.callbackQunt = { newValue in
            if newValue == 0 {
                cell.ProductQunt.text = item.productQunt
                DataBaseCartManager.sharedDB.remove(modelAt: self.products[indexPath.item])
                self.cartTblView.beginUpdates()
                self.cart.remove(at: indexPath.row)
                self.cartTblView.deleteRows(at: [indexPath], with: .fade)
                self.cartTblView.endUpdates()
            } else {
                cell.ProductQunt.text = "\( Int(item.productQunt ?? "")! + newValue)"
                cell.ProductPrice.text = "\((Int(item.productQunt ?? "")! + newValue) * Int(item.productPrice))$"
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
}
