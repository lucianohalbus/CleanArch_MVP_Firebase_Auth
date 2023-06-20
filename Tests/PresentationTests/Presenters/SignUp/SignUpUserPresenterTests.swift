import XCTest
import Domain
import Presentation

final class SignUpUserPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertModel(fieldName: "email"))
            exp.fulfill()
        }
        sut.signUp(signUpModel: makeSignViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertModel(fieldName: "password"))
            exp.fulfill()
        }
        sut.signUp(signUpModel: makeSignViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_error_message_if_invalidEmail_is_provider() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertModel(fieldName: "Email"))
            exp.fulfill()
        }
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(signUpModel: makeSignViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignViewModel()
        sut.signUp(signUpModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_addUser_with_correct_value() {
        let addUserSpy = AddUserSpy()
        let sut = makeSut(addUser: addUserSpy)
        sut.signUp(signUpModel: makeSignViewModel())
        XCTAssertEqual(addUserSpy.userSignBody, makeUserSignBody())
    }
    
    func test_signUp_should_show_error_message_if_addUser_fails() {
        let alertViewSpy = AlertViewSpy()
        let addUserSpy = AddUserSpy()
        let sut = makeSut(alertView: alertViewSpy, addUser: addUserSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertModel(message: "Algo inexperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.signUp(signUpModel: makeSignViewModel())
        addUserSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_success_message_if_addUser_succeeds() {
        let alertViewSpy = AlertViewSpy()
        let addUserSpy = AddUserSpy()
        let sut = makeSut(alertView: alertViewSpy, addUser: addUserSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertModel(message: "Conta criada com sucesso."))
            exp.fulfill()
        }
        sut.signUp(signUpModel: makeSignViewModel())
        addUserSpy.completeWithUser(makeUserModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_loading_before_and_after_addUser() {
        let loadingViewSpy = LoadingViewSpy()
        let addUserSpy = AddUserSpy()
        let sut = makeSut(addUser: addUserSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.signUp(signUpModel: makeSignViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        addUserSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }

}

extension SignUpUserPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addUser: AddUserSpy = AddUserSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), userLogin: UserLoginSpy = UserLoginSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpUserPresenter {
        let sut = SignUpUserPresenter(alertView: alertView, emailValidator: emailValidator, addUser: addUser, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
