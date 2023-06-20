import Foundation
import UI
import Presentation
import Validation
import Data
import Infra

class SignUpFactory {
    static func makeController() -> SignViewController {
        let controller = SignViewController.instatiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]")!
        let remoteAddUser = RemoteAddUser(url: url, httpClient: alamofireAdapter)
        let presenter = SignUpUserPresenter(alertView: controller, emailValidator: emailValidatorAdapter, addUser: remoteAddUser, loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
