//

import Foundation
import Domain

public final class SighUpPresenter {
    private let validation: Validation
    private let alertView: AlertView
    private let addUser: AddUser
    private let loadingView: LoadingView
    
    public init(validation: Validation, alertView: AlertView, addUser: AddUser, loadingView: LoadingView) {
        self.validation = validation
        self.alertView = alertView
        self.addUser = addUser
        self.loadingView = loadingView
    }
    
    public func signUp(viewModel: SignUpRequest) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertModel(title: "Falha na Validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingModel(isLoading: true))
            addUser.add(addUserBody: viewModel.toAddUserBody()) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingModel(isLoading: false))
                switch result {
                case .failure(let error):
                    let errorMessage: String!
                    switch error {
                    case .emailInUse: errorMessage = "Este email já está em uso."
                    default: errorMessage = "Algo inexperado aconteceu, tente novamente em alguns instantes."
                    }
                    self.alertView.showMessage(viewModel: AlertModel(title: "Error", message: errorMessage))
                case .success: self.alertView.showMessage(viewModel: AlertModel(title: "Sucesso", message: "Conta criada com sucesso."))
                }
            }
        }
    }
}
