import Foundation
import Domain

class AddUserSpy: AddUser {
    var addUserBody: AddUserBody?
    var completion: ((Result<UserModel, DomainError>) -> Void)?
    
    func add(addUserBody: AddUserBody, completion: @escaping (Result<UserModel, DomainError>) -> Void) {
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
