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
        let configurations: [AppConfiguration] = [
            .planets(URL(string: "https://swapi.dev/api/planets/")!),
            .vehicles(URL(string: "https://swapi.dev/api/vehicles/")!),
            .starships(URL(string: "https://swapi.dev/api/starships/")!)
        ]

        appConfiguration = configurations.randomElement()

        // Печать выбранной конфигурации и отправка запроса
        print("Selected configuration: \(String(describing: appConfiguration))")
        if let config = appConfiguration {
            NetworkService.request(for: config)
        }

        return true
    }
}
