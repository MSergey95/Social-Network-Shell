//
//  AppDelegate.swift
//  Navigation
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Инициализация окна
        window = UIWindow(frame: UIScreen.main.bounds)

        // Инициализация и запуск AppCoordinator
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()

        return true
    }
}
