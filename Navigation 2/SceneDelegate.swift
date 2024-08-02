//
//  SceneDelegate.swift
//  Navigation 2
//
//  Created by Сергей Минеев on 3/20/24.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UITabBarControllerDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        // Создание экранов
        let loginVC = LogInViewController()
        let profileVC = ProfileViewController()

        // Назначение иконок для табов
        loginVC.tabBarItem = UITabBarItem(title: "Login", image: UIImage(systemName: "person.fill"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)

        // Создание и настройка таб бар контроллера
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [UINavigationController(rootViewController: loginVC), UINavigationController(rootViewController: profileVC)]
        tabBarController.delegate = self

        // Настройка внешнего вида таб бара
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.tintColor = .systemBlue

        // Установка таб бар контроллера в качестве корневого
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }

    // Функция делегата для проверки разрешения перехода на вкладку "Profile"
    @objc func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // Разрешаем переход, если пользователь вошел в систему
        if let navController = viewController as? UINavigationController, navController.viewControllers.first is ProfileViewController {
            return UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        }
        return true
    }
}



// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}
func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}
func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}
func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}
func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

