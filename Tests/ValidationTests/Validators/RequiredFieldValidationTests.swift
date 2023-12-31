import XCTest
import Presentation
import Validation

class RequiredFieldValidationTests: XCTestCase {
    func test_signUp_should_return_error_if_field_is_not_provider() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["name": "any_name"])
        XCTAssertEqual(errorMessage, "Please, enter a valid Email")
    }
    
    func test_signUp_should_return_error_with_correct_fieldLabel() {
        let sut = makeSut(fieldName: "email", fieldLabel: "age")
        let errorMessage = sut.validate(data: ["name": "any_name"])
        XCTAssertEqual(errorMessage, "Please, enter a valid age")
    }
    
    func test_signUp_should_return_nil_if_field_is_provider() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["email": "any_name@test.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_signUp_should_return_nil_if_no_data_is_provider() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "Please, enter a valid Email")
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
