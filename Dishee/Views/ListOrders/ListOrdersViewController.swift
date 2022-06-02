//
//  ListOrdersViewController.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import UIKit
import ProgressHUD

class ListOrdersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var orders: [Order] = [
//        .init(id: "id", name: "Mai", dish:
//                .init(id: "id1", name: "Chef's Salads", description: "Awsome helthey meal", image: "https://picsum.photos/100/200", calories: 100)
//        ),
//        .init(id: "id", name: "Safie", dish:
//                .init(id: "id1", name: "Pet Food", description: "Awsome helthey meal", image: "https://picsum.photos/100/200", calories: 100)
//        ),
//        .init(id: "id", name: "James", dish:
//                .init(id: "id1", name: "Curry", description: "Awsome helthey meal", image: "https://picsum.photos/100/200", calories: 100)
//        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Orders"
        registerCells()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ProgressHUD.show()
        NetworkService.shared.fetchOrders{[weak self] (result) in
            switch result {
                
            case .success(let orders):
                ProgressHUD.dismiss()
                
                self?.orders = orders
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

extension ListOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setup(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
}
