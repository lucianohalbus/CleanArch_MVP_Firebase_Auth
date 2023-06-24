import Foundation
import Presentation

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMenssage: String?

    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMenssage
    }
    
    func simulateError() {
        self.errorMenssage = "Erro"
    }
}
