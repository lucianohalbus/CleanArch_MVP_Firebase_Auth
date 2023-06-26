import XCTest
import UIKit
import Presentation
@testable import UI

final class SignUpViewControllerTest: XCTestCase {
    
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_saveButton_calls_signUp_on_tap() {
        var signUpViewModel: SignUpRequest?
        let sut = makeSut(signUpSpy: { signUpViewModel = $0 })
        sut.signUpButton?.simulateTap()
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        XCTAssertEqual(signUpViewModel, SignUpRequest(email: email, password: password, returnSecureToken: true))
    }
}

extension SignUpViewControllerTest {
    func makeSut(signUpSpy: ((SignUpRequest) -> Void)? = nil) -> SignUpViewController {
        let sut = SignUpViewController.instatiate()
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return sut
    }
}
