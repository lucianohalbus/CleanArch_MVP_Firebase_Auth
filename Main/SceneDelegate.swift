import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = NavigationController()
        let welcomeViewController = makeWellcomeController(nav: nav)
        nav.setRootViewController(welcomeViewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
