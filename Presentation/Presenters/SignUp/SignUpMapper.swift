import Foundation
import Domain

public final class SignUpMapper {
    static func toAddUserModel(viewModel: SignUpModel) -> AddUserModel {
        return AddUserModel(email: viewModel.email!, password: viewModel.password!, returnSecureToken: viewModel.returnSecureToken)
    }
}
