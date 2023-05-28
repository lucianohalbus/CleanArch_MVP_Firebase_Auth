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
        httpClient.post(url: url)
    }
}

protocol HttpPostClient {
    func post(url: URL)
}

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_corret_url() throws {
        let url: URL = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpclientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.data, data)
    }
    
    func test_add_should_call_httpClient_with_corret_data() throws {

        let httpClientSpy = HttpclientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }

}

extension RemoteAddAccountTests {
    class HttpclientSpy: HttpPostClient {
        var url: URL?
        
        func post(url: URL) {
            self.url = url
        }
    }
}
