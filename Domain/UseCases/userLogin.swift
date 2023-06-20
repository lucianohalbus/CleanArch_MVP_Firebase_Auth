import Foundation

public protocol UserLogin {
    func login(userSignBody: UserSignBody, completion: @escaping (Result<UserLoginModel, DomainError>) -> Void)
}
