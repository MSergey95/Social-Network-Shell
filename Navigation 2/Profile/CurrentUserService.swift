//
//  CurrentUserService.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 8/5/24.
//

import Foundation
class CurrentUserService: UserService {
    private let currentUser: User

    init(user: User) {
        self.currentUser = user
    }

    func getUser(login: String) -> User? {
        return login == currentUser.login ? currentUser : nil
    }
}
