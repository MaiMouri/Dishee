//
//  Dish.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import Foundation

struct Dish: Decodable {
    let id, name, description, image: String?
    let calories: Int?
    
    var formattedCalories: String {
        return "\(calories ?? 0) kcal"
//        return String(format: "%.2f kcals", calories ?? 0)
    }
}
