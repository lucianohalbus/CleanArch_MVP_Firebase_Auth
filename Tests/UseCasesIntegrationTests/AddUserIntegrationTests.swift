import XCTest
import Data
import Infra
import Domain

class AddUserIntegrationTests: XCTestCase {

    func test_add_user() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[FIREBASE_API_KEY]")!
        let sut = RemoteAddUser(url: url, httpClient: alamofireAdapter)
        let addUserBody = AddUserBody(nickName: "nickname", email: "testEmail", password: "012345", passwordConfirmation: "012345", returnSecureToken: true)
        let exp = expectation(description: "waiting")
        sut.add(addUserBody: addUserBody)  { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let user):
                XCTAssertNotNil(user.localID)
                XCTAssertEqual(user.email, addUserBody.email)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
