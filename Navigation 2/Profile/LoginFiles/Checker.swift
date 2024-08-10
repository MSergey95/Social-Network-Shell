//
//  Checker.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 8/9/24.
//

final class Checker {
    static let shared = Checker()

    private let login = "test"
    private let password = "1234"

    private init() {}

    func check(login: String, password: String) -> Bool {
        print("Checking login: \(login) against stored login: \(self.login)")
        print("Checking password: \(password) against stored password: \(self.password)")
        let result = login == self.login && password == self.password
        print("Check result: \(result)")
        return result
    }
}
