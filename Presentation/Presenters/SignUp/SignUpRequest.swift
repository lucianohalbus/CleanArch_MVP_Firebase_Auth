import Foundation
import Domain

public struct SignUpRequest: Model {
    public var email: String?
    public var password: String?
    public var returnSecureToken: Bool
    
    public init(email: String? = nil, password: String? = nil, returnSecureToken: Bool = true) {
        self.email = email
        self.password = password
        self.returnSecureToken = returnSecureToken
    }
    
    public func toAddUserBody() -> AddUserBody {
        return AddUserBody(email: self.email!, password: self.password!, returnSecureToken: true)
    }
}
