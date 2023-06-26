import Foundation

func makeApiUrl(path: String) -> URL {
    let environment: EnvironmentVar = .debug
    let key = environment.firebaseApiKey
    print("key key \(key)")
    let url = URL(string: "\(environment.path.firebaseApiBaseUrl)\(path)\(key)")!
    
    
print("zico path \(url)")


    return url
}
