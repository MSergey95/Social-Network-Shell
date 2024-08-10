//
//  UserService.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 8/5/24.
//

import Foundation
import UIKit
protocol UserService {
    func getUser(login: String) -> User?
}

