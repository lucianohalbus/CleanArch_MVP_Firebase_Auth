import Foundation
import Presentation

func makeSignUpViewModel(email: String? = "any_email", password: String? = "any_password") -> SignUpRequest {
    return SignUpRequest(email: email, password: password, returnSecureToken: true)
}

func makeLoginViewModel(email: String? = "any_email", password: String? = "any_password") -> LoginRequest {
    return LoginRequest(email: email, password: password)
}
