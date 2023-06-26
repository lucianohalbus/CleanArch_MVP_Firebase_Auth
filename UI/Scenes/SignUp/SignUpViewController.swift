import Foundation
import UIKit
import Presentation

public final class SignUpViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    
    public var signUp: ((SignUpRequest) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Fun"
        signUpButton?.layer.cornerRadius = 5
        signUpButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
        loadingIndicator.color = Color.primaryDark
        logoImage.makeRounded()
    }
    
    @objc private func signUpButtonTapped() {

        let viewModel = SignUpRequest(email: emailTextField?.text, password: passwordTextField?.text, returnSecureToken: true) 
        signUp?(viewModel)
    }
}

extension SignUpViewController: LoadingView {
    public func display(viewModel: Presentation.LoadingModel) {
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
