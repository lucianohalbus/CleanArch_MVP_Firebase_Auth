import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeLoginController() -> LoginViewController {
    return makeLoginControllerWith(userAuth: makeRemoteAuthentication())
}

public func makeLoginControllerWith(userAuth: UserAuth) -> LoginViewController {
    let controller = LoginViewController.instatiate()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), userAuth: userAuth)
    controller.login = presenter.login
    return controller
}

public func makeLoginValidations() -> [Validation] {
    return ValidationBuilder.field("email").label("Email").required().email().build() +
    ValidationBuilder.field("password").label("Password").required().build()
}
