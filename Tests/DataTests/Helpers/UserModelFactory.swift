import Foundation
import Domain

func makeUserModel() -> UserModel {
    return UserModel(
        idToken: "any_id_token",
        email: "any_name",
        refreshToken: "any_refresh_token",
        expiresIn: "any_expires_in",
        localID: "any_local_id"
    )
}

func makeUserSignBody() -> UserSignBody {
    return UserSignBody(
        email: "any_email",
        password: "any_password",
        returnSecureToken: true
    )
}

func makeUserLoginModel() -> UserLoginModel {
    return UserLoginModel(
        localID: "any_local_id",
        email: "any_name",
        idToken: "any_id_token",
        registered: false,
        refreshToken: "any_refresh_token",
        expiresIn: "any_expires_in"
    )
}
