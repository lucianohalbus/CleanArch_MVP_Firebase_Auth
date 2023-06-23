import Foundation

public protocol AddUser {
    typealias Result = Swift.Result<UserModel, DomainError>
    func add(addUserBody: AddUserBody, completion: @escaping (AddUser.Result) -> Void)
}
public struct AddUserBody: Model {
    public var nickName: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    public var returnSecureToken: Bool
    
    public init(nickName: String, email: String, password: String, passwordConfirmation: String, returnSecureToken: Bool) {
        self.nickName = nickName
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
        self.returnSecureToken = returnSecureToken
    }
}
