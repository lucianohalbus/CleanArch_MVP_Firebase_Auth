import Foundation
import Domain

class AddUserSpy: AddUser {
    var addUserModel: AddUserModel?
    var completion: ((Result<Domain.UserModel, Domain.DomainError>) -> Void)?
    
    func add(addUserModel: Domain.AddUserModel, completion: @escaping (Result<Domain.UserModel, Domain.DomainError>) -> Void) {
        self.addUserModel = addUserModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithUser(_ user: UserModel) {
        completion?(.success(user))
    }
}
