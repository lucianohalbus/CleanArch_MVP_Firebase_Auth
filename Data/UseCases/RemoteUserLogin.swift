import Foundation
import Domain

public final class RemoteUserLogin: UserLogin {
    private let url: URL
    private let httpClient: HttpPostClient

    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func login(userLoginBody: UserLoginBody, completion: @escaping (Result<UserLoginModel, DomainError>) -> Void) {
        httpClient.post(to: url, with: userLoginBody.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: UserLoginModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}

