//
//  ApiResponse.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/02.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
