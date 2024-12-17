import UIKit

// MARK: - Протокол координатора
protocol Coordinator: AnyObject {
    func start()
}

final class AppCoordinator: Coordinator {
    var window: UIWindow
    var loginCoordinator: LoginCoordinator?

    // Инициализация
    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Запуск приложения
    func start() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

        if isLoggedIn {
            showMainTabBar()
        } else {
            showLogin()
        }
    }

    private func showLogin() {
        loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator?.start()

        // Колбэк для успешного входа
        loginCoordinator?.onLoginSuccess = { [weak self] in
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self?.showMainTabBar()
        }
    }
    private func showMainTabBar() {
        let tabBarController = UITabBarController()

        let userProfile = UserProfile(name: "User", status: "active")
        let profileViewModel = ProfileViewModel(userProfile: userProfile)

        let feedVC = FeedViewController(profileViewModel: profileViewModel)
        let favoritesVC = FavoritesViewController()

        // Профиль через координатор
        let profileNavController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController)
        profileCoordinator.start()

        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: feedVC),
            UINavigationController(rootViewController: favoritesVC),
            profileNavController
        ]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
