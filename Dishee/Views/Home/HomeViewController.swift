//
//  HomeViewController.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
//        .init(id: "id1", name: "Africa Dish", image: "https://picsum.photos/100/200"),
//        .init(id: "id2", name: "Africa Dish 2", image: "https://picsum.photos/100/200"),
//        .init(id: "id1", name: "Africa Dish 3", image: "https://picsum.photos/100/200"),
//        .init(id: "id1", name: "Africa Dish 4", image: "https://picsum.photos/100/200"),
//        .init(id: "id1", name: "Africa Dish 5", image: "https://picsum.photos/100/200")
    ]
    
    var populars:[Dish] = [
//        .init(id: "id1", name: "Misoshiru", description: "This is a traditional japanese soup", image: "https://picsum.photos/100/200", calories: 34),
//        .init(id: "id1", name: "Misoshiru", description: "This is a traditional japanese soup", image: "https://picsum.photos/100/200", calories: 134),
//        .init(id: "id1", name: "Soup Curry", description: "This is a traditional japanese soup", image: "https://picsum.photos/100/200", calories: 234)
    ]
    
    var specials: [Dish] = [
//        .init(id: "id1", name: "Chef's Salads", description: "Awsome helthey meal", image: "https://picsum.photos/100/200", calories: 100),
//        .init(id: "id1", name: "Tom Yam kun", description: "Spicy Thai soup", image: "https://picsum.photos/100/200", calories: 200),
//        .init(id: "id1", name: "Fried Tofu", description: "Healtey Protain", image: "https://picsum.photos/100/200", calories: 140)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        ProgressHUD.show()
        NetworkService.shared.fetchAllCategories{ [weak self] (result) in
            switch result {
            case .success(let allDishes):
                ProgressHUD.dismiss()
                self?.categories = allDishes.categories ?? []
                self?.populars = allDishes.populars ?? []
                self?.specials = allDishes.specials ?? []
                self?.categoryCollectionView.reloadData()
                self?.popularCollectionView.reloadData()
                self?.specialsCollectionView.reloadData()
                print("It was successful")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
                print("FROM Home The error is: \(error.localizedDescription)")
            }
        }
        //        NetworkService.shared.myFirstRequest { (result) in
        //            switch result {
        //            case .success(let data):
        //                print("The decoded data is \(data)")
        //            case .failure(let error):
        //                print("The error is: \(error.localizedDescription)")
        //            }
        //        }
        
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialsCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
        case specialsCollectionView:
            return specials.count
        default:
            return 0
        }
        //        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
            cell.setup(dish: populars[indexPath.row])
            
            return cell
        case specialsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
            cell.setup(dish: specials[indexPath.row])
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = ListDishesViewController.instantiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = DishDetailViewController.instantiate()
            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
            
            // pop up
            //            navigationController?.present(controller, animated: true, completion: nil)
            
            // left to right
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
