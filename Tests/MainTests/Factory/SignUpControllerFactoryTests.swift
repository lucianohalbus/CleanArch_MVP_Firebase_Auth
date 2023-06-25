import XCTest
import Main
import UI
import Validation

final class SignUpControllerFactoryTests: XCTestCase {
    func test_background_request_should_complete_on_main_thread() {
        let (sut, addUserSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            addUserSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_compose_with_correct_validation() {
        let validation = makeSignUpValidations()
        XCTAssertEqual(validation[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "name", fieldLabel: "nickname"))
        XCTAssertEqual(validation[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validation[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validation[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"))
        XCTAssertEqual(validation[4] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "passwordConfirmation", fieldNameToCompare: "password", fieldLabel: "Confirm Password"))
    }
}

//Usa o decorator (design patters para fazer o tratamento das threads.
extension SignUpControllerFactoryTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addUserSpy: AddUserSpy){
        let addUserSpy = AddUserSpy()
        let sut = makeSignUpControllerWith(addUser: MainQueueDispatchDecorator(addUserSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addUserSpy, file: file, line: line)
        return (sut, addUserSpy)
    }
}
