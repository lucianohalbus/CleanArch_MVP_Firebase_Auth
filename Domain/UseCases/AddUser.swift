import Foundation

public protocol AddUser {
    func add(addUserBody: AddUserBody, completion: @escaping (Result<UserModel, DomainError>) -> Void)
}

public struct AddUserBody: Model {
    public var email: String
    public var password: String
    public var returnSecureToken: Bool = true
    
    public init(email: String = "", password: String = "", returnSecureToken: Bool = true) {
        self.email = email
        self.password = password
        self.returnSecureToken = returnSecureToken
    }
}
