import Foundation
import UIKit

extension UIImageView {
    
    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
