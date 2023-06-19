import Foundation

public protocol userLogin {
    func login(userLoginBody: UserLoginBody, completion: @escaping (Result<UserModel, DomainError>) -> Void)
}

public struct UserLoginBody: Model {
    public var email: String
    public var password: String
    public var returnSecureToken: Bool = true
    
    public init(email: String = "", password: String = "", returnSecureToken: Bool = true) {
        self.email = email
        self.password = password
        self.returnSecureToken = returnSecureToken
    }
}
