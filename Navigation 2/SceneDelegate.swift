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

        print("Tab bar controller delegate set")
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("tabBarController shouldSelect called")
        if let navController = viewController as? UINavigationController, navController.viewControllers.first is ProfileViewController {
            let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
            print("isUserLoggedIn: \(isUserLoggedIn)")
            if !isUserLoggedIn {
                showLoginAlert(tabBarController: tabBarController)
                return false
            }
        }
        return true
    }

    private func showLoginAlert(tabBarController: UITabBarController) {
        print("Showing login alert")
        let alert = UIAlertController(title: "Access Denied", message: "You must be logged in to view this page.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        tabBarController.present(alert, animated: true, completion: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
