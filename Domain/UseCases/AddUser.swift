import Foundation

public protocol AddUser {
    func add(userSignBody: UserSignBody, completion: @escaping (Result<UserModel, DomainError>) -> Void)
}
