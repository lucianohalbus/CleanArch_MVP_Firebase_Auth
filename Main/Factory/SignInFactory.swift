import Foundation
import UI
import Presentation
import Validation
import Data
import Infra

class SignInFactory {
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController.instatiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]")!
        let remoteUserLogin = RemoteUserLogin(url: url, httpClient: alamofireAdapter)
        let presenter = SignInUserPresenter(alertView: controller, emailValidator: emailValidatorAdapter, loadingView: controller, userLogin: remoteUserLogin)
        controller.signIn = presenter.signIn
        return controller
    }
}

