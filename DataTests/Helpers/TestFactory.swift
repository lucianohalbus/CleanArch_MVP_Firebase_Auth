//

import Foundation

func makeInvalidDate() -> Data {
    return Data("".utf8)
}

func makeValidDate() -> Data {
    return Data("{\"name\":\"Rodrigo\"}".utf8)
}

func makeURL() -> URL {
    return URL(string: "http://any-url.com")!
}