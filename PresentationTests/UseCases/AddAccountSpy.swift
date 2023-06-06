//

import Foundation
import Domain

class AddAccountSpy: AddAccount {
    var addAccountModel: AddAccountModel?
    var completion: ((Result<Domain.AccountModel, Domain.DomainError>) -> Void)?
    
    func add(addAccountModel: Domain.AddAccountModel, completion: @escaping (Result<Domain.AccountModel, Domain.DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithAccount(_ account: AccountModel) {
        completion?(.success(account))
    }
}
