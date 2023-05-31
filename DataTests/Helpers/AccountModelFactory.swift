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
