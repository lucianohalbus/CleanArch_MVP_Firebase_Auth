import Foundation
import UI

public func makeWellcomeController(nav: NavigationController) -> WelcomeViewController {
    let router = WelcomeRouter(nav: nav, loginFactory: makeLoginController, signUpFactory: makeSignUpController)
    let controller = WelcomeViewController.instatiate()
    controller.signUp = router.goToSignUp
    controller.login = router.goToLogin
    return controller
}
