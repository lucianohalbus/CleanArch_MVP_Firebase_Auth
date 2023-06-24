import Foundation

public protocol UserAuth {
    typealias Result = Swift.Result<UserAuthModel, DomainError>
    func auth(userAuthBody: UserAuthBody, completion: @escaping (UserAuth.Result) -> Void)
}

public struct UserAuthBody: Model {
    public var email: String
    public var password: String
    public var returnSecureToken: Bool
    
    public init(email: String, password: String, returnSecureToken: Bool) {
        self.email = email
        self.password = password
        self.returnSecureToken = returnSecureToken
    }
}
