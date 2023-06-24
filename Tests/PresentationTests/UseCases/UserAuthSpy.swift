import Foundation
import Domain

class UserAuthSpy: UserAuth {
    var userAuthBody: UserAuthBody?
    var completion: ((UserAuth.Result) -> Void)?
    
    func auth(userAuthBody: UserAuthBody, completion: @escaping (UserAuth.Result) -> Void) {
        self.userAuthBody = userAuthBody
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithAccount(_ user: UserAuthModel) {
        completion?(.success(user))
    }
}
