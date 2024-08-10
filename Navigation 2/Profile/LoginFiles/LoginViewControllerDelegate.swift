//
//  LoginViewControllerDelegate.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 8/9/24.
//

import Foundation
protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}
