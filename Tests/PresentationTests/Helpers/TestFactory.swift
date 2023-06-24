import Foundation
import Presentation

func makeSignUpViewModel(nickName: String? = "any_name", email: String? = "any_email", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpRequest {
    return SignUpRequest(nickName: nickName, email: email, password: password, passwordConfirmation: passwordConfirmation, returnSecureToken: true)
}

func makeLoginViewModel(email: String? = "any_email", password: String? = "any_password") -> LoginRequest {
    return LoginRequest(email: email, password: password)
}
