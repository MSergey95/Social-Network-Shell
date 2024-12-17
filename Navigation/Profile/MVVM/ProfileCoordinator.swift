import UIKit

final class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Запуск координатора
    func start() {
        showProfile()
    }

    // MARK: - Показ профиля
    private func showProfile() {
        let profileVC = ProfileViewController()

        navigationController.pushViewController(profileVC, animated: true)
    }

    // MARK: - Переход на экран фотографий
    func showPhotos() {
        let photosVC = PhotosViewController()
        photosVC.title = "Фотографии"
        navigationController.pushViewController(photosVC, animated: true)
    }

    // MARK: - Переход на экран настроек
    func showSettings() {
        let settingsVC = UIViewController()
        settingsVC.view.backgroundColor = .systemBackground
        settingsVC.title = "Настройки"

        // Добавляем простой элемент интерфейса, чтобы настройки не были пустыми
        let label = UILabel()
        label.text = "Здесь будут настройки"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        settingsVC.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: settingsVC.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: settingsVC.view.centerYAnchor)
        ])

        navigationController.pushViewController(settingsVC, animated: true)
    }
}
