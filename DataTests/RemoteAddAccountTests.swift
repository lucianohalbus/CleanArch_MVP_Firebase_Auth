//

import XCTest
import Domain

class RemoteAddAccount {
    private let url: URL
    let httpClient: HttpPostClient

    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data)
    }
}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_corret_url() throws {
        let url: URL = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpclientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let addAccountModel: AddAccountModel = AddAccountModel(
            name: "anyName",
            email: "anyEmail",
            password: "anyPassword",
            passwordConfirmation: "anyPassword"
        )
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_with_corret_data() throws {
        let url: URL = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpclientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let addAccountModel: AddAccountModel = AddAccountModel(
            name: "anyName",
            email: "anyEmail",
            password: "anyPassword",
            passwordConfirmation: "anyPassword"
        )
        let data = try? JSONEncoder().encode(addAccountModel)
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, data)
    }

}

extension RemoteAddAccountTests {
    class HttpclientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
