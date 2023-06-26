import Foundation

public protocol AddUser {
    typealias Result = Swift.Result<UserModel, DomainError>
    func add(addUserBody: AddUserBody, completion: @escaping (AddUser.Result) -> Void)
}
public struct AddUserBody: Model {
    public var email: String
    public var password: String
    public var returnSecureToken: Bool
    
    public init(email: String, password: String, returnSecureToken: Bool) {
        self.email = email
        self.password = password
        self.returnSecureToken = returnSecureToken
    }
}
