import Foundation

public final class Environment {
    public enum EnvironmentVar: String {
        case apiBaseUrl = "API_BASE_URL"
        case apiKey = "API_KEY"
    }
    
    public static func variable(_ key: EnvironmentVar) -> String {
        return Bundle.main.infoDictionary?[key.rawValue] as! String
    }
}

public enum EnvironmentVar {

    case debug
    case release
    
    var keys: Keys {
        switch self {
        case .debug:
            return Keys(
                firebaseApiKey: "FIREBASE_API_KEY"
            )
        case .release:
            return Keys(
                firebaseApiKey: "FIREBASE_API_KEY"
            )
        }
    }
    
    var path: Paths {
        switch self {
        case .debug:
            return Paths(
                firebaseApiBaseUrl: "https://identitytoolkit.googleapis.com/v1"
            )
        case .release:
            return Paths(
                firebaseApiBaseUrl: "https://identitytoolkit.googleapis.com/v1"
            )
        }
    }
    
    struct Paths {
        let firebaseApiBaseUrl: String
    }
    
    struct Keys {
        let firebaseApiKey: String
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict: [String: Any] = Bundle.main.infoDictionary else {
            debugPrint("Plist file not found")
            return [:]
        }
        return dict
    }()
    
    var firebaseApiKey: String {
        guard let key: String = EnvironmentVar.infoDictionary[self.keys.firebaseApiKey] as? String else {
            debugPrint("Error when getting FIREBASE API KEY")
            return ""
        }
        return key
    }
}
