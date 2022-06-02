//
//  Route.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import Foundation

enum Route {
    static let baseUrl = "https://yummie.glitch.me/"
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String)
    case fetchOrders
    case temp
    
    var description: String {
        switch self {
            
        case .fetchAllCategories: return "/dish-categories"
        case .placeOrder(let dishId): return "/orders/\(dishId)"
        case .fetchCategoryDishes(let categoryId): return "/dishes/\(categoryId)"
        case .temp: return "/dishes/cat1"
        case .fetchOrders:
            return "/orders"
        }
    }
}
