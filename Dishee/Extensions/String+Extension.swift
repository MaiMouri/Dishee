//
//  String+Extension.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/06/01.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
