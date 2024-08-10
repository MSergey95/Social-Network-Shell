//
//  LoginFactory.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 8/10/24.
//

import Foundation
protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
