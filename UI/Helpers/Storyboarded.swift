//

import Foundation
import UIKit

public protocol Storyboarded {
    static func instatiate() -> Self
}

//Pega o Prefixo do nome da classe (tudo antes do ViewController)
//Use esse prefixo para nomear as storyboards.
extension Storyboarded where Self: UIViewController{
    public static func instatiate() -> Self {
        let vcName = String(describing: self)
        let sbName = vcName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        let sb = UIStoryboard(name: sbName, bundle: bundle)
        return sb.instantiateViewController(identifier: vcName) as! Self
    }
}
