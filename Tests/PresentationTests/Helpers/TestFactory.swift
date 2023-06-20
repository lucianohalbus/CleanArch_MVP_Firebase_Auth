import Foundation
import Presentation

func makeSignViewModel(email: String? = "any_email", password: String? = "any_password", returnSecureToken: Bool = true) -> SignModel {
    return SignModel(email: email, password: password, returnSecureToken: true)
}

func makeRequiredAlertModel(fieldName: String) -> AlertModel {
    return AlertModel(title: "Falha na Validação", message: "O campo \(fieldName) é obrigatório")
}

func makeInvalidAlertModel(fieldName: String) -> AlertModel {
    return AlertModel(title: "Falha na Validação", message: "\(fieldName) inválido")
}

func makeErrorAlertModel(message: String) -> AlertModel {
    return AlertModel(title: "Error", message: message)
}

func makeSuccessAlertModel(message: String) -> AlertModel {
    return AlertModel(title: "Sucesso", message: message)
}
