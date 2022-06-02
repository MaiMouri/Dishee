//
//  Order.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import Foundation

struct Order: Decodable {
    let id: String?
    let name: String?
    let dish: Dish?
}
