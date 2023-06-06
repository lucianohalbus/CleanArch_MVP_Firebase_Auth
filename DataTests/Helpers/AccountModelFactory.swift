//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(
        id: "anyId",
        name: "anyName",
        email: "anyEmail",
        password: "anyPassword"
    )
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(
        name: "any_name",
        email: "any_email@mail.com",
        password: "any_password",
        passwordConfirmation: "any_password"
    )
}
