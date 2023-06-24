import Foundation
import Domain

// Decorator - adiciona novo comportamento à classe, sem alterar a classe.
public final class MainQueueDispatchDecorator<T> {
    private let instante: T
    
    public init( _ instance: T) {
        self.instante = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainQueueDispatchDecorator: AddUser where T: AddUser {
    public func add(addUserBody: Domain.AddUserBody, completion: @escaping (AddUser.Result) -> Void) {
        instante.add(addUserBody: addUserBody) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchDecorator: UserAuth where T: UserAuth {
    public func auth(userAuthBody: UserAuthBody, completion: @escaping (UserAuth.Result) -> Void) {
        instante.auth(userAuthBody: userAuthBody) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
