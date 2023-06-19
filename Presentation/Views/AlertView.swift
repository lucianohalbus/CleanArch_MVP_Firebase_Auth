//

import Foundation

public protocol AlertView {
    func showMessage(viewModel: AlertModel)
}

public struct AlertModel: Equatable {
    public var title: String
    public var message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
