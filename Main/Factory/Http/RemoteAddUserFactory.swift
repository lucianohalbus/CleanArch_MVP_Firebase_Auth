import Foundation
import Data
import Domain

func makeRemoteAddUser() -> AddUser {
    return makeRemoteAddUserWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAddUserWith(httpClient: HttpPostClient) -> AddUser {
    let remoteAddUser = RemoteAddUser(url: makeApiUrl(path: "/accounts:signUp?key=AIzaSyAHq6QnsXe3r8RVOn5_NbZ7XHXM-k8bSJs"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAddUser)
}
