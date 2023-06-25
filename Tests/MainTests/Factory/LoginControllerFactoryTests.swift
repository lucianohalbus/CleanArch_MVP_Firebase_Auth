import XCTest
import Main
import UI
import Validation

final class LoginControllerFactoryTests: XCTestCase {
    
    func test_background_request_should_complete_on_main_thread() {
        let (sut, authenticationSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.login?(makeLoginViewModel())
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            authenticationSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_compose_with_correct_validation() {
        let validation = makeLoginValidations()
        XCTAssertEqual(validation[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validation[1] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validation[2] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"))
    }
}

//Usa o decorator (design patters para fazer o tratamento das threads.
extension LoginControllerFactoryTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: LoginViewController, userAuth: UserAuthSpy) {
        let userAuthSpy = UserAuthSpy()
        let sut = makeLoginControllerWith(userAuth: MainQueueDispatchDecorator(userAuthSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: userAuthSpy, file: file, line: line)
        return (sut, userAuthSpy)
    }
}
