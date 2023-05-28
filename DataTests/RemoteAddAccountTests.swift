//

import XCTest

class RemoteAddAccount {
    private let url: URL
    let httpClient: HttpClient

    init(url: URL, httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add() {
        httpClient.post(url: url)
        
    }
}

protocol HttpClient {
    func post(url: URL)
}

final class RemoteAddAccountTests: XCTestCase {

    func test_() throws {
        let url: URL = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpclientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
       
    }
    
    class HttpclientSpy: HttpClient {
        var url: URL?
        
        func post(url: URL) {
            self.url = url        }
        
        
    }


}
