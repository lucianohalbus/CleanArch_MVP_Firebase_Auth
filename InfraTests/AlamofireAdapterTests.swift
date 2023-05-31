//

import XCTest
import Data
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?) {
        let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_post_should_make_request_with_valid_url_and_method() {
        let url = makeURL()
        let sut = makeSut()
        sut.post(to: url, with: makeValidDate())
        let exp = expectation(description: "waiting")
        UrlProtocolStrub.observeRequest { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for:  [exp], timeout: 1)
    }
    
    func test_post_should_make_request_with_no_data() {
        let sut = makeSut()
        sut.post(to: makeURL(), with: nil)
        let exp = expectation(description: "waiting")
        UrlProtocolStrub.observeRequest { request in
            XCTAssertNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for:  [exp], timeout: 1)
    }
}

extension AlamofireAdapterTests {
    func makeSut() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStrub.self]
        let session = Session(configuration: configuration)
        return AlamofireAdapter(session: session)
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
