import Foundation
import Domain

public final class SignUpMapper {
    static func toAddUserBody(viewModel: SignUpModel) -> AddUserBody {
        return AddUserBody(email: viewModel.email!, password: viewModel.password!, returnSecureToken: viewModel.returnSecureToken)
    }
}
