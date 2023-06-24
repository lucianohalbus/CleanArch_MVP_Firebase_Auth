import Foundation
import Domain

public final class RemoteUserLogin: UserAuth {
    private let url: URL
    private let httpClient: HttpPostClient

    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func auth(userAuthBody: UserAuthBody, completion: @escaping (UserAuth.Result) -> Void) {
        httpClient.post(to: url, with: userAuthBody.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: UserAuthModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .unauthorized: completion(.failure(.expiredSession))
                default: completion(.failure(.unexpected))
                }
            }
        }
    }
}

