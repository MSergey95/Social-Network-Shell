//
//  AppDelegate.swift
//  Navigation
//
import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    // Добавляем переменную для хранения конфигурации
    var appConfiguration: AppConfiguration?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Инициализация окна
        window = UIWindow(frame: UIScreen.main.bounds)

        // Инициализация и запуск AppCoordinator
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()

        // Рандомная инициализация appConfiguration
        appConfiguration = AppConfiguration.allCases.randomElement()

        // Печать выбранной конфигурации и отправка запроса
        if let config = appConfiguration {
            print("Selected configuration: \(config)")
            NetworkService.request(url: config.url)
        }

        return true
    }
}
