//
//  LoginInspector.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 8/9/24.
//
import Foundation


final class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        print("LoginInspector is checking login: \(login), password: \(password)")
        let result = Checker.shared.check(login: login, password: password)
        print("Checker result: \(result)")
        return result
    }
}
