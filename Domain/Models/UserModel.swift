import Foundation

public struct UserModel: Model {
    public let idToken: String
    public let email: String
    public let refreshToken: String
    public let expiresIn: String
    public let localID: String

        enum CodingKeys: String, CodingKey {
            case idToken, email, refreshToken, expiresIn
            case localID = "localId"
        }
    
    public init(idToken: String, email: String, refreshToken: String, expiresIn: String, localID: String) {
        self.idToken = idToken
        self.email = email
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.localID = localID
    }
}

