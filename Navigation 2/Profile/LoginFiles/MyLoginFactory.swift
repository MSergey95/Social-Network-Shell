//
//  MyLoginFactory.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 8/10/24.
//

import Foundation
struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
