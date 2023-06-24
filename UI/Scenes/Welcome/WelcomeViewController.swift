import Foundation
import UIKit
import Presentation

public final class WelcomeViewController: UIViewController, Storyboarded {
 
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public var login: (() -> Void)?
    public var signUp: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        
        title = "4Fun"
        
        loginButton?.layer.cornerRadius = 8
        loginButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        signUpButton?.layer.cornerRadius = 8
        signUpButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        logoImage.makeRounded()
        
        titleLabel.text = "Firebase\nAuthentication\nTemplate"

    }
    
    @objc private func loginButtonTapped() {
       login?()
    }
    
    @objc private func signUpButtonTapped() {
       signUp?()
    }
}
