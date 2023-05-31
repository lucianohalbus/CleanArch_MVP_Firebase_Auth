//

import XCTest
import Domain
import Data

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_corret_url() throws {
        let url: URL = makeURL()
        let (sut, httpClientSpy) = makeSut()
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_corret_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel: AddAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func test_add_should_complete_with_error_if_client_complete_with_failure() throws {
        let (sut, httpClientSpy) = makeSut()
        expected(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_add_should_complete_with_account_if_client_complete_with_valid_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let expectedAccount = makeAccountModel()
        expected(sut, completeWith: .success(expectedAccount)) {
            httpClientSpy.completeWithData(expectedAccount.toData()!)
        }
    }
        
    func test_add_should_complete_with_error_if_client_complete_with_invalid_data() throws {
        let (sut, httpClientSpy) = makeSut()
        expected(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithData(makeInvalidDate())
        }
    }
    
    func test_add_should_not_complete_if_sut_has_been_deallocated() throws {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeURL(), httpClient: httpClientSpy)
        var result: Result<AccountModel, DomainError>?
        sut?.add(addAccountModel: makeAddAccountModel()) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
        
    }
}

extension RemoteAddAccountTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func makeInvalidDate() -> Data {
        return Data("".utf8)
    }
    
    func makeURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
        
    }
    
    func expected(_ sut: RemoteAddAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(
            name: "anyName",
            email: "anyEmail",
            password: "anyPassword",
            passwordConfirmation: "anyPassword"
        )
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(
            id: "anyId",
            name: "anyName",
            email: "anyEmail",
            password: "anyPassword"
        )
    }
    
    class HttpClientSpy: HttpPostClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
        
        func completeWithData(_ data: Data) {
            completion?(.success(data))
        }
    }
}
