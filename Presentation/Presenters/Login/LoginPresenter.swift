//

import Foundation
import Domain

public final class LoginPresenter {
    private let validation: Validation
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let userAuth: UserAuth
    
    public init(validation: Validation, alertView: AlertView, loadingView: LoadingView, userAuth: UserAuth) {
        self.validation = validation
        self.alertView = alertView
        self.loadingView = loadingView
        self.userAuth = userAuth
    }
    
    public func login(viewModel: LoginRequest) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertModel(title: "Falha na Validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingModel(isLoading: true))
            userAuth.auth(authenticationBody: viewModel.toAuthenticationBody()) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingModel(isLoading: false))
                switch result {
                case .failure(let error):
                    let errorMessage: String!
                    switch error {
                    case .expiredSession: errorMessage = "Email e/ou senha inválidos."
                    default: errorMessage = "Algo inexperado aconteceu, tente novamente em alguns instantes."
                    }
                    self.alertView.showMessage(viewModel: AlertModel(title: "Error", message: errorMessage))
                case .success: self.alertView.showMessage(viewModel: AlertModel(title: "Sucesso", message: "Login feito com sucesso."))
                }
            }
        }
    }
}
