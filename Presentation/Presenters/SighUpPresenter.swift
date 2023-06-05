//

import Foundation

public class SighUpPresenter {
    private let alertView: AlertView

    public init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na Validação", message: message))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
           return "O campo nome é obrigatório"
        }
        
        if viewModel.email == nil || viewModel.email!.isEmpty {
            return "O campo email é obrigatório"
        }
        
        if viewModel.password == nil || viewModel.password!.isEmpty {
           return "O campo senha é obrigatório"
        }
        
        if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "O campo confimar senha é obrigatório"
        }
        
        return nil
    }
}

public struct SignUpViewModel {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
