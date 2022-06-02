//
//  DishCategory.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import Foundation

struct DishCategory: Decodable {
    let id, name, image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}
