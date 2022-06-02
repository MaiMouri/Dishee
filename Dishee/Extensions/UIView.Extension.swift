//
//  UIView.Extension.swift
//  Dishee
//
//  Created by Mai Mouri on 2022/05/31.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
