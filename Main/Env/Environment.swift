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
