import Foundation
import Data
import Domain

func makeRemoteAddUser() -> AddUser {
    return makeRemoteAddUserWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAddUserWith(httpClient: HttpPostClient) -> AddUser {
    let remoteAddUser = RemoteAddUser(url: makeApiUrl(path: "signuo"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAddUser)
}
