//

import Foundation
import UIKit
import Presentation

public final class SignUpViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    public var signUp: ((SignUpModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        saveButton?.layer.cornerRadius = 5
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func saveButtonTapped() {
        let viewModel = SignUpModel(email: emailTextField?.text, password: passwordTextField?.text, returnSecureToken: true)
        signUp?(viewModel)
    }
}

extension SignUpViewController: LoadingView {
    public func display(viewModel: Presentation.LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    public func showMessage(viewModel: Presentation.AlertModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
        
    }
}
