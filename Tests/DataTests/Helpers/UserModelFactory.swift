import Foundation
import Domain

func makeUserModel() -> UserModel {
    return UserModel(
        idToken: "any_id_token",
        email: "any_email",
        refreshToken: "any_refresh_token",
        expiresIn: "any_expires_in",
        localID: "any_local_id"
    )
}

func makeAddUserBody() -> AddUserBody {
    return AddUserBody(
        email: "any_email",
        password: "any_password",
        returnSecureToken: true
    )
}

func makeUserAuthBody() -> UserAuthBody {
    UserAuthBody(
        email: "any_email",
        password: "any_password",
        returnSecureToken: true
    )
}

func makeUserAuthModel() -> UserAuthModel {
    return UserAuthModel(
        localID: "any_local_id",
        email: "any_email",
        idToken: "any_id_token",
        registered: false,
        refreshToken: "any_refresh_token",
        expiresIn: "any_expires_in"
    )
}
