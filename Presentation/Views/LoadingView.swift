import Foundation

public protocol LoadingView {
    func display(viewModel: LoadingModel)
}

public struct LoadingModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
}
