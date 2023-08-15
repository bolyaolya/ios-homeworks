//
//  Extension.swift
//  Navigation
//
//  Created by Ольга Бойко on 15.08.2023.
//

import Foundation
import UIKit

extension String {
    var localized : String {
        NSLocalizedString(self, comment: "")
    }
}

extension UIColor {
    static func createColor(lightMode : UIColor, darkMode : UIColor) -> UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return darkMode
            } else {
                return lightMode
            }
        }
    }
}

let colorMainBackground = UIColor.createColor(lightMode: .white, darkMode: .systemGray)
let colorSecondaryBackground = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray3)
let colorTextColor = UIColor.createColor(lightMode: .black, darkMode: .white)
let colorSecondaryTextColor = UIColor.createColor(lightMode: .systemGray, darkMode: .lightGray)
let colorBorderColor = UIColor.createColor(lightMode: .lightGray, darkMode: .white)
let colorTabBarBackground = UIColor.createColor(lightMode: .lightGray, darkMode: .systemGray6)
let colorTabBarTintColor = UIColor.createColor(lightMode: .systemBlue, darkMode: .white)
