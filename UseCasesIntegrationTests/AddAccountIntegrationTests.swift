//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {

    func test_add_account() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://4974284e-263f-41ef-8564-2e907616483b.mock.pstmn.io/signuo")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "testName", email: "testEmail", password: "012345", passwordConfirmation: "012345")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel)  { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(account.name, addAccountModel.name)
                XCTAssertEqual(account.email, addAccountModel.email)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
