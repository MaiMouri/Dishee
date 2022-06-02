//
//  AllDishes.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/02.
//

import Foundation

struct AllDishes: Decodable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}
