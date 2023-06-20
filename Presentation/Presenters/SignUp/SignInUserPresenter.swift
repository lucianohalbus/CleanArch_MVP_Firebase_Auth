//

import Foundation
import Domain

public final class SignInUserPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let loadingView: LoadingView
    private let userLogin: UserLogin
    
    public init(alertView: AlertView, emailValidator: EmailValidator, loadingView: LoadingView, userLogin: UserLogin) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.loadingView = loadingView
        self.userLogin = userLogin
    }
    
    public func signIn(signInModel: SignModel) {
        if let message = validate(signUpModel: signInModel) {
            alertView.showMessage(viewModel: AlertModel(title: "Falha na Validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            userLogin.login(userSignBody: SignUpMapper.toUserSignBody(viewModel: signInModel)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertModel(title: "Error", message: "Algo inexperado aconteceu, tente novamente em alguns instantes."))
                case .success: self.alertView.showMessage(viewModel: AlertModel(title: "Sucesso", message: "Conta criada com sucesso."))
                }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            }
        }
    }
    
    private func validate(signUpModel: SignModel) -> String? {
        if signUpModel.email == nil || signUpModel.email?.isEmpty ?? false {
            return "O campo email é obrigatório"
        } else if signUpModel.password == nil || signUpModel.password?.isEmpty ?? false {
            return "O campo password é obrigatório"
        } else if signUpModel.returnSecureToken == false {
            return "O campo returnSecureToken é obrigatório"
        } else if !emailValidator.isValid(email: signUpModel.email ?? "") {
            return "Email inválido"
        }
        return nil
    }
}
