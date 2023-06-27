import Foundation

func makeApiUrl(path: String) -> URL {
    let environment: EnvironmentVar = .debug
    let apiKey = environment.firebaseApiKey
    let url = URL(string: "\(environment.path.firebaseApiBaseUrl)\(path)\(apiKey)")!
    return url
}
