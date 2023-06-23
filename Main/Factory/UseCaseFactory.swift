import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    static func makeRemoteAddUser() -> AddUser {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]")!
        return RemoteAddUser(url: url, httpClient: alamofireAdapter)
    }
}
