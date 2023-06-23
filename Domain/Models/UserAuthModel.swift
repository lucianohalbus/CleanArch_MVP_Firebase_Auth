import Foundation

public struct UserAuthModel: Model {
    let localID: String
    let email: String
    let idToken: String
    let registered: Bool
    let refreshToken: String
    let expiresIn: String
    
    enum CodingKeys: String, CodingKey {
        case localID = "localId"
        case email, idToken, registered, refreshToken, expiresIn
    }
    
    public init(localID: String, email: String, idToken: String, registered: Bool, refreshToken: String, expiresIn: String) {
        self.localID = localID
        self.email = email
        self.idToken = idToken
        self.registered = registered
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
    }
}
