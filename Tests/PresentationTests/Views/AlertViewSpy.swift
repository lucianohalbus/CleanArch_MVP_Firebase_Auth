//

import Foundation
import Presentation

class AlertViewSpy: AlertView {
    var viewModel: AlertModel?
    var emit: ((AlertModel) -> Void)?
    
    func observe(completion: @escaping (AlertModel) -> Void) {
        self.emit = completion
    }
    
    func showMessage(viewModel: AlertModel) {
        self.emit?(viewModel)
    }
}
