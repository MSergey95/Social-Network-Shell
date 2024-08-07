//
//   User.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 8/5/24.
//

import Foundation
import UIKit

class User {
    let login: String
    let fullName: String
    let avatar: UIImage
    let status: String

    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
