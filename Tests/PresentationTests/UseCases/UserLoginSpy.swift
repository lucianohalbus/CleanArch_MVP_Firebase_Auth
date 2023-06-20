import Foundation
import Domain

class UserLoginSpy: UserLogin {
    var userSignBody: UserSignBody?
    var completion: ((Result<UserLoginModel, DomainError>) -> Void)?
    
    func login(userSignBody: UserSignBody, completion: @escaping (Result<UserLoginModel, DomainError>) -> Void) {
        self.userSignBody = userSignBody
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithUser(_ user: UserLoginModel) {
        completion?(.success(user))
    }
}
