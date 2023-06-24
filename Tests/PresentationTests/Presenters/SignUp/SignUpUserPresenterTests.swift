import XCTest
import Domain
import Presentation

final class SignUpUserPresenterTests: XCTestCase {
    
    func test_signUp_should_call_addAcount_with_correct_values() {
        let addUserSpy = AddUserSpy()
        let sut = makeSut(addUser: addUserSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addUserSpy.addUserBody, makeAddUserBody())
    }
    
    func test_signUp_should_show_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addUserSpy = AddUserSpy()
        let sut = makeSut(alertView: alertViewSpy, addUser: addUserSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertModel(title: "Error", message: "Algo inexperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addUserSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_email_in_use_if_addAccount_returns_forbidden() {
        let alertViewSpy = AlertViewSpy()
        let addUserSpy = AddUserSpy()
        let sut = makeSut(alertView: alertViewSpy, addUser: addUserSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertModel(title: "Error", message: "Este email já está em uso."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addUserSpy.completeWithError(.emailInUse)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_success_message_if_addAccount_succeeds() {
        let alertViewSpy = AlertViewSpy()
        let addUserSpy = AddUserSpy()
        let sut = makeSut(alertView: alertViewSpy, addUser: addUserSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertModel(title: "Sucesso", message: "Conta criada com sucesso."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addUserSpy.completeWithUser(makeUserModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_loading_before_and_after_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let addUserSpy = AddUserSpy()
        let sut = makeSut(addUser: addUserSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingModel(isLoading: true))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingModel(isLoading: false))
            exp2.fulfill()
        }
        addUserSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }

    func test_signUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_signUp_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertModel(title: "Falha na Validação", message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpUserPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), addUser: AddUserSpy = AddUserSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpUserPresenter {
        let sut = SignUpUserPresenter(validation: validation, alertView: alertView, addUser: addUser, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
