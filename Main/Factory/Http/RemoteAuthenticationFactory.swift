import Foundation
import Data
import Domain

func makeRemoteAuthentication() -> UserAuth {
    return makeRemoteAuthenticationWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthenticationWith(httpClient: HttpPostClient) -> UserAuth {
    let remoteUserLogin = RemoteUserLogin(url: makeApiUrl(path: "accounts:signInWithPassword?key="), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteUserLogin)
}
