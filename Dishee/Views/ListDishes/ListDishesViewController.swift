//
//  ListDishesViewController.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import UIKit
import ProgressHUD

class ListDishesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: DishCategory!
    
    var dishes: [Dish] = [
//        .init(id: "id1", name: "Misoshiru", description: "This is a traditional japanese soup", image: "https://picsum.photos/100/200", calories: 34),
//        .init(id: "id1", name: "Misoshiru", description: "This is a traditional japanese soup", image: "https://picsum.photos/100/200", calories: 134),
//        .init(id: "id1", name: "Soup Curry", description: "This is a traditional japanese soup", image: "https://picsum.photos/100/200", calories: 234)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.name
        registerCells()
        
        ProgressHUD.show()
        NetworkService.shared.fetchCategoryDishes(categoryId: category.id ?? "") {[weak self] (result) in
        switch result {
            
        case .success(let dishes):
            ProgressHUD.dismiss()
            self?.dishes = dishes
            self?.tableView.reloadData()
            
        case .failure(let error):
            ProgressHUD.showError(error.localizedDescription)
        }
        }
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
}

extension ListDishesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setup(dish: dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


///* Generate Request */
//func createRequest(route: Route,
//                   method: Method,
//                   parameters: [String: Any]? = nil) -> URLRequest {
//    // code
//}
//
///* Make Request to the Backend */
//func request<T: Decodable>(route: Route,
//                   method: Method,
//                   parameters: [String: Any]? = nil,
//                           type: T.type,
//                           complition: ((Result<T, Error>) -> Void)?) {
//    // code
//}
//
///* Decode Response */
//func hadleResponse<T: Decodable>(result: Result<Data, Error>?),
//completion: ((Result<T, Error>) -> Void)? = nil {
//    //code
//}
