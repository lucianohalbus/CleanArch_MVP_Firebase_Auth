import Foundation
import Domain

class AddUserSpy: AddUser {
    var addUserBody: AddUserBody?
    var completion: ((Result<Domain.UserModel, Domain.DomainError>) -> Void)?
    
    func add(addUserBody: Domain.AddUserBody, completion: @escaping (Result<Domain.UserModel, Domain.DomainError>) -> Void) {
        self.addUserBody = addUserBody
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithUser(_ user: UserModel) {
        completion?(.success(user))
    }
}
