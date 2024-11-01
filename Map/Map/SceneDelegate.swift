import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController() // Устанавливаем ViewController корневым контроллером
        self.window = window
        window.makeKeyAndVisible()
    }
}

    func sceneDidDisconnect(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена отключается системой.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена становится активной.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Этот метод вызывается, когда сцена собирается перейти в неактивное состояние.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Этот метод вызывается при переходе сцены из фона на передний план.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Этот метод вызывается при переходе сцены из переднего плана в фон.
    }

