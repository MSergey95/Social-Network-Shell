import UIKit

final class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // Создаём экземпляр пользовательского профиля
        let userProfile = UserProfile(name: "User", status: "active")
        let profileViewModel = ProfileViewModel(userProfile: userProfile)

        // Создаём FeedViewController и передаём данные
        let feedVC = FeedViewController(profileViewModel: profileViewModel)
        navigationController.pushViewController(feedVC, animated: false)
    }
}
