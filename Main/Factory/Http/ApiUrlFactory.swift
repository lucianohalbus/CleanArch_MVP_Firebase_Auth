import Foundation

func makeApiUrl(path: String) -> URL {
    let environment: EnvironmentVar = .debug
    let url = URL(string: "\(environment.path.firebaseApiBaseUrl)\(path)")!
    return url
}
