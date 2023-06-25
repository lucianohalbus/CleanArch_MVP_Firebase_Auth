import XCTest
import Domain
import Presentation

final class LoginPresenterTests: XCTestCase {

    func test_login_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertModel(title: "Validation Fails", message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_call_authentication_with_correct_values() {
        let userAuthSpy = UserAuthSpy()
        let sut = makeSut(userAuth: userAuthSpy)
        sut.login(viewModel: makeLoginViewModel())
        XCTAssertEqual(userAuthSpy.userAuthBody, makeUserAuthBody())
    }

    func test_login_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_login_should_show_error_message_if_authentication_fails() {
        let alertViewSpy = AlertViewSpy()
        let userAuthSpy = UserAuthSpy()
        let sut = makeSut(alertView: alertViewSpy, userAuth: userAuthSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertModel(title: "Error", message: "Something unexpected happened. Please try again"))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        userAuthSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_show_expired_session_if_authentication_Completes_with_expired_session() {
        let alertViewSpy = AlertViewSpy()
        let userAuthSpy = UserAuthSpy()
        let sut = makeSut(alertView: alertViewSpy, userAuth: userAuthSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertModel(title: "Error", message: "Invalid email or password"))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        userAuthSpy.completeWithError(.expiredSession)
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_show_success_message_if_authentication_succeeds() {
        let alertViewSpy = AlertViewSpy()
        let userAuthSpy = UserAuthSpy()
        let sut = makeSut(alertView: alertViewSpy, userAuth: userAuthSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertModel(title: "Success", message: "Login Successfully"))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        userAuthSpy.completeWithAccount(makeUserAuthModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_show_loading_before_and_after_authentication() {
        let loadingViewSpy = LoadingViewSpy()
        let userAuthSpy = UserAuthSpy()
        let sut = makeSut(userAuth: userAuthSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingModel(isLoading: true))
            exp.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingModel(isLoading: false))
            exp2.fulfill()
        }
        userAuthSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
}

extension LoginPresenterTests {
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), userAuth: UserAuthSpy = UserAuthSpy(), validation: ValidationSpy = ValidationSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), file: StaticString = #file, line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(validation: validation, alertView: alertView, loadingView: loadingView, userAuth: userAuth)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

