//
//  UIColor+.swift
//  MapProject
//
//  Created by Anton Tolstov on 07.09.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, *) {
            self.init { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
}
