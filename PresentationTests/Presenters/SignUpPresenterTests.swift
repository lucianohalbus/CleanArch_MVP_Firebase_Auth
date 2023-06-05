//

import XCTest
import Presentation

final class SignUpPresenterTests: XCTestCase {

    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validação", message: "O campo nome é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validação", message: "O campo email é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validação", message: "O campo senha é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", password: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validação", message: "O campo confimar senha é obrigatório"))
    }
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email@mail.com", password: "any_password", passwordConfirmation: "wrong_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validação", message: "Falha ao confirmar senha"))
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() {
        let (sut, _, emailValidatorSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "invalid_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_invalidEmail_is_provider() {
        let (sut, alertViewSpy, emailValidatorSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "invalid_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
        emailValidatorSpy.isValid = false
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validação", message: "Email invalido."))
    }

}

extension SignUpPresenterTests {
    func makeSut() -> (sut: SighUpPresenter, alertViewSpy: AlertViewSpy, emailValidatorSpy: EmailValidatorSpy) {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = SighUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        return (sut, alertViewSpy, emailValidatorSpy)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?

        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
            
        }
    }
}



