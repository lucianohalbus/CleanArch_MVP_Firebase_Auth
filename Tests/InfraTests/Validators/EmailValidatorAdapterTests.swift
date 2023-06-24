import XCTest
import Infra

final class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_emails() throws {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "teste@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "teste@google.com"))
        XCTAssertTrue(sut.isValid(email: "teste@yahoo.com.br"))
        XCTAssertTrue(sut.isValid(email: "teste@icloud.com"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
