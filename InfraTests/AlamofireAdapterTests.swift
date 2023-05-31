//

import XCTest
import Data
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL) {
        session.request(url).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_() {
        let url = makeURL()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStrub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url)
        let exp = expectation(description: "waiting")
        UrlProtocolStrub.observeRequest { request in
            XCTAssertEqual(url, request.url)
            exp.fulfill()
        }
        wait(for:  [exp], timeout: 1)
    }
}


class UrlProtocolStrub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStrub.emit = completion
        
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override open func startLoading() {
        UrlProtocolStrub.emit?(request)
    }
    
    override open func stopLoading() {
        
    }

}
