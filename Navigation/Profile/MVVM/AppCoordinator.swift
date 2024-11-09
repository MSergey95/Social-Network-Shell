//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Сергей Минеев on 8/16/24.
//

import Foundation
import UIKit

// Протокол для всех координаторов, чтобы у них был метод `start`
protocol Coordinator {
    func start()
}

// Главный координатор, который будет управлять всей навигацией
final class AppCoordinator: Coordinator {
    var window: UIWindow
    var tabBarController: UITabBarController
    var profileCoordinator: ProfileCoordinator?
    var feedCoordinator: FeedCoordinator?

    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController()
    }

    func start() {
        // Инициализация UINavigationController для каждого модуля
        let profileNC = UINavigationController()
        let feedNC = UINavigationController()

        // Инициализация дочерних координаторов
        profileCoordinator = ProfileCoordinator(navigationController: profileNC)
        feedCoordinator = FeedCoordinator(navigationController: feedNC)

        // Запуск дочерних координаторов
        profileCoordinator?.start()
        feedCoordinator?.start()

        // Настройка вкладок
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        feedNC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "text.bubble"), selectedImage: UIImage(systemName: "text.bubble.fill"))

        // Добавление контроллеров во вкладки
        tabBarController.viewControllers = [profileNC, feedNC]

        // Настройка окна
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
