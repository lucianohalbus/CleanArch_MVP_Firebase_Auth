import Foundation
import Domain

public final class SignUpMapper {
    static func toUserSignBody(viewModel: SignModel) -> UserSignBody {
        return UserSignBody(email: viewModel.email!, password: viewModel.password!, returnSecureToken: viewModel.returnSecureToken)
    }
    
    
}
