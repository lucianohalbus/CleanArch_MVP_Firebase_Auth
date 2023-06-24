import Foundation
import Domain

public struct SignUpRequest: Model {
    public var nickName: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    public var returnSecureToken: Bool
    
    public init(nickName: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil, returnSecureToken: Bool = true) {
        self.nickName = nickName
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
        self.returnSecureToken = returnSecureToken
    }
    
    public func toAddUserBody() -> AddUserBody {
        return AddUserBody(nickName: self.nickName!, email: self.email!, password: self.password!, passwordConfirmation: self.passwordConfirmation!, returnSecureToken: true)
    }
}
