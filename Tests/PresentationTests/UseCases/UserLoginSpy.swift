import Foundation
import Domain

class UserLoginSpy: UserAuth {
    var userSignBody: UserSignBody?
    var completion: ((Result<UserAuthModel, DomainError>) -> Void)?
    
    func login(userSignBody: UserSignBody, completion: @escaping (Result<UserAuthModel, DomainError>) -> Void) {
        self.userSignBody = userSignBody
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithUser(_ user: UserAuthModel) {
        completion?(.success(user))
    }
}
