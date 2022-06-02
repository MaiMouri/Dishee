//
//  DishDetailViewController.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import UIKit
import ProgressHUD

class DishDetailViewController: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }

    private func populateView(){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }
    
    @IBAction func placeOrderButtonClicked(_ sender: Any) {
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces),!name.isEmpty else {
            ProgressHUD.showError("Please Enter your name")
            return
        }
        
        ProgressHUD.show("Placing Order...")
        NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) {(result) in
            switch result {
                
            case .success(let test):
                ProgressHUD.showSuccess("Thank you, \(test.name!)✨\nYour order has been received.👩‍🍳")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}
