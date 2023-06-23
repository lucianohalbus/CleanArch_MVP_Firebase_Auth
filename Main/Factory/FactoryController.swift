import Foundation
import UI
import Presentation
import Validation
import Domain

class FactoryController {
    static func makeController(addUser: AddUser) -> SignViewController {
        let controller = SignViewController.instatiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SignUpUserPresenter(alertView: controller, emailValidator: emailValidatorAdapter, addUser: addUser, loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
