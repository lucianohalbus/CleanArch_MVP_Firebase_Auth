import Foundation
import Domain

class UserAuthSpy: UserAuth {
    var authenticationBody: AuthenticationBody?
    var completion: ((UserAuth.Result) -> Void)?
    
    func auth(authenticationBody: AuthenticationBody, completion: @escaping (UserAuth.Result) -> Void) {
        self.authenticationBody = authenticationBody
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithAccount(_ user: UserAuthModel) {
        completion?(.success(user))
    }
}
