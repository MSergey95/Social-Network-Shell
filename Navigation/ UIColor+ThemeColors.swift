//
//   UIColor+ThemeColors.swift
//  Navigation
//
//  Created by Сергей Минеев on 11/4/24.
//

import Foundation
import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }

    // Примеры кастомных цветов для светлой и темной тем
    static var customBackground: UIColor {
        return createColor(lightMode: .white, darkMode: .black)
    }

    static var customTextColor: UIColor {
        return createColor(lightMode: .black, darkMode: .white)
    }
    
    static var customPlaceholderColor: UIColor {
            return createColor(lightMode: .darkGray, darkMode: .lightGray)
        }

    static var customButtonBackground: UIColor {
        return createColor(lightMode: UIColor(red: 0.25, green: 0.5, blue: 0.75, alpha: 1.0),
                           darkMode: UIColor(red: 0.15, green: 0.3, blue: 0.45, alpha: 1.0))
    }

    // Цвет для успешного ответа
    static var customSuccessTextColor: UIColor {
        return createColor(lightMode: UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0),
                           darkMode: UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0))
    }

    // Цвет для ошибки
    static var customErrorTextColor: UIColor {
        return createColor(lightMode: UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0),
                           darkMode: UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1.0))
    }
}
