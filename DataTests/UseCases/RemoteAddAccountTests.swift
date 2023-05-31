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

}

extension RemoteAddAccountTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpclientSpy) {
        let httpClientSpy = HttpclientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeInvalidDate() -> Data {
        return Data("".utf8)
    }
    
    func makeURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    func expected(_ sut: RemoteAddAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead")
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
    
    class HttpclientSpy: HttpPostClient {
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
