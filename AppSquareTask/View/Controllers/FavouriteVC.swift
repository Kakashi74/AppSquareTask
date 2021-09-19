//
//  FavouriteVC.swift
//  AppSquareTask
//
//  Created by Ahmed on 9/7/21.
//  Copyright © 2021  All rights reserved.
//

import UIKit
import CoreData

class FavouriteVC: UIViewController {
 
    @IBOutlet weak var wishListTbleView : UITableView!{
        didSet {
            wishListTbleView.register(UINib(nibName: "WishListCell", bundle: nil), forCellReuseIdentifier: "WishListCell")
            wishListTbleView.separatorStyle = .none
        }
    }

    var products = HomeViewModel()
    var favProduct  = [Product](){
        didSet{
            wishListTbleView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favProduct =  DataBaseManegar.sharedDB.fetchFavRecipes()
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton){
        self.popVC()
    }
    
    @IBAction func cartBtnTapped(_ sender: UIButton){
        self.poshWithoutData(identifire: "CartVC")
    }
}

extension FavouriteVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wishListTbleView.dequeueReusableCell(withIdentifier: "WishListCell") as! WishListCell
        cell.configureCell(product: favProduct[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        //remove object from core data
        let context:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(favProduct[indexPath.row] as NSManagedObject)
        do{
         try context.save()
            print("deleted successfully")
        }catch let error as NSError{
          print("Could not save. \(error), \(error.userInfo)")
        }

        //update UI methods
        wishListTbleView.beginUpdates()
        favProduct.remove(at: indexPath.row)
        wishListTbleView.deleteRows(at: [indexPath], with: .fade)
        wishListTbleView.endUpdates()

        appDelegate.saveContext()
        }
    }
}
