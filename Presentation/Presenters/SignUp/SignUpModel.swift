//

import Foundation
import Domain

public struct SignUpModel: Model {
    public var email: String?
    public var password: String?
    public var returnSecureToken: Bool = true
    
    public init(email: String? = nil, password: String? = nil, returnSecureToken: Bool = true) {
        self.email = email
        self.password = password
        self.returnSecureToken = returnSecureToken
    }
}
