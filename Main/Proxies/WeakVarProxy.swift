import Foundation
import Presentation

final class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: Presentation.AlertModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: Presentation.LoadingModel) {
        instance?.display(viewModel: viewModel)
    }
}
