//

import XCTest
import UIKit
import Presentation

final class SignUpViewControllerTest: XCTestCase {
    
    func test_loading_is_hidden_on_start() {
        let sb = UIStoryboard(name: "SignUP", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sb = UIStoryboard(name: "SignUP", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        XCTAssertNotNil(sut as LoadingView)
    }
}
