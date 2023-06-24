import XCTest
import UIKit
@testable import UI

final class WelcomeRouterTest: XCTestCase {
    
    func test_go_to_login_calls_nav_with_correct_viewController() {
        let (sut, nav) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
    
    func test_go_to_signUp_calls_nav_with_correct_viewController() {
        let (sut, nav) = makeSut()
        sut.goToSignUp()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is SignUpViewController)
    }
}

extension WelcomeRouterTest {
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
        let loginFactorySpy = LoginFactorySpy()
        let signUpFactorySpy = SignUpFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin, signUpFactory: signUpFactorySpy.makeSignUp)
        return (sut, nav)
    }
}

extension WelcomeRouterTest {
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instatiate()
        }
    }
    
    class SignUpFactorySpy {
        func makeSignUp() -> SignUpViewController {
            return SignUpViewController.instatiate()
        }
    }
}

