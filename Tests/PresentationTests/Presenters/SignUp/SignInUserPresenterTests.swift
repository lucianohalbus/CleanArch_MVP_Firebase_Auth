import XCTest
import Domain
import Presentation

final class SignInUserPresenterTests: XCTestCase {
    
    func test_signIn_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertModel(fieldName: "email"))
            exp.fulfill()
        }
        sut.signIn(signInModel: makeSignViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertModel(fieldName: "password"))
            exp.fulfill()
        }
        sut.signIn(signInModel: makeSignViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_should_show_error_message_if_invalidEmail_is_provider() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertModel(fieldName: "Email"))
            exp.fulfill()
        }
        emailValidatorSpy.simulateInvalidEmail()
        sut.signIn(signInModel: makeSignViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signInViewModel = makeSignViewModel()
        sut.signIn(signInModel: signInViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signInViewModel.email)
    }
    
    func test_signIn_should_loginUser_with_correct_value() {
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(userLogin: userLoginSpy)
        sut.signIn(signInModel: makeSignViewModel())
        XCTAssertEqual(userLoginSpy.userSignBody, makeUserSignBody())
    }
    
    func test_signIn_should_show_error_message_if_loginUser_fails() {
        let alertViewSpy = AlertViewSpy()
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(alertView: alertViewSpy, userLogin: userLoginSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertModel(message: "Algo inexperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.signIn(signInModel: makeSignViewModel())
        userLoginSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_should_show_success_message_if_userLogin_succeeds() {
        let alertViewSpy = AlertViewSpy()
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(alertView: alertViewSpy, userLogin: userLoginSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertModel(message: "Conta criada com sucesso."))
            exp.fulfill()
        }
        sut.signIn(signInModel: makeSignViewModel())
        userLoginSpy.completeWithUser(makeUserLoginModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_should_show_loading_before_and_after_userLogin() {
        let loadingViewSpy = LoadingViewSpy()
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(loadingView: loadingViewSpy, userLogin: userLoginSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.signIn(signInModel: makeSignViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        userLoginSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
}

extension SignInUserPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(),
                 loadingView: LoadingViewSpy = LoadingViewSpy(), userLogin: UserLoginSpy = UserLoginSpy(), file: StaticString = #file, line: UInt = #line) -> SignInUserPresenter {
        let sut = SignInUserPresenter(alertView: alertView, emailValidator: emailValidator, loadingView: loadingView, userLogin: userLogin)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
