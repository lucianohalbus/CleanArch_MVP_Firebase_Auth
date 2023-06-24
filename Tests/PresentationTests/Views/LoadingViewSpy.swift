//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    var emit: ((LoadingModel) -> Void)?
    
    func observe(completion: @escaping (LoadingModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: LoadingModel) {
        self.emit?(viewModel)
    }
}
