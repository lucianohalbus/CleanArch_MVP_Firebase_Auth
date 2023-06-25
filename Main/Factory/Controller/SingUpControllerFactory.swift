import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeSignUpController() -> SignUpViewController {
    return makeSignUpControllerWith(addUser: makeRemoteAddUser())
}

public func makeSignUpControllerWith(addUser: AddUser) -> SignUpViewController {
    let controller = SignUpViewController.instatiate()
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    let presenter = SighUpPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), addUser: addUser, loadingView: WeakVarProxy(controller))
    controller.signUp = presenter.signUp
    return controller
}

public func makeSignUpValidations() -> [Validation] {
    return ValidationBuilder.field("name").label("nickname").required().build() +
    ValidationBuilder.field("email").label("Email").required().email().build() +
    ValidationBuilder.field("password").label("Password").required().build() +
    ValidationBuilder.field("passwordConfirmation").label("Confirm Password").sameAs("password").build()
}
