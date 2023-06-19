import Foundation

public struct UserLoginModel: Model {
    let localID: String
    let email: String
    let displayName: String
    let idToken: String
    let registered: Bool
    let refreshToken, expiresIn: String
    
    enum CodingKeys: String, CodingKey {
        case localID = "localId"
        case email, displayName, idToken, registered, refreshToken, expiresIn
    }
    
    public init(localID: String, email: String, displayName: String, idToken: String, registered: Bool, refreshToken: String, expiresIn: String) {
        self.localID = localID
        self.email = email
        self.displayName = displayName
        self.idToken = idToken
        self.registered = registered
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
    }
}
