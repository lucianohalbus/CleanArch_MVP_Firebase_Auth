import Foundation

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
        
        guard let apiKey: String = ProcessInfo.processInfo.environment["FIREBASE_API_KEY"] else {
            debugPrint("Error when getting FIREBASE API KEY")
            return ""
        }
        return apiKey
    }
}
