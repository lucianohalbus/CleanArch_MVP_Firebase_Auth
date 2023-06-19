//

import Foundation
import UI
import Presentation
import Validation
import Data
import Infra

class SignUpFactory {
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController.instatiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://4974284e-263f-41ef-8564-2e907616483b.mock.pstmn.io/signuo")!
        let remoteAddUser = RemoteAddUser(url: url, httpClient: alamofireAdapter)
        let presenter = SighUpPresenter(alertView: controller, emailValidator: emailValidatorAdapter, addUser: remoteAddUser, loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
