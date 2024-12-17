import UIKit

final class LoginCoordinator: Coordinator {
    private let window: UIWindow
    var onLoginSuccess: (() -> Void)?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = { [weak self] in
            self?.onLoginSuccess?()
        }

        let navigationController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
