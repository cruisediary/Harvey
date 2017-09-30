import Foundation

public final class HarveyResponse {

    let url: URL
    let data: Data
    let statusCode: Int
    let headers: [String: String]?

    lazy var httpUrlResponse: HTTPURLResponse = HTTPURLResponse(url: self.url, statusCode: self.statusCode, httpVersion: nil, headerFields: self.headers)!

    init(url: URL, data: Data, statusCode: Int, headers: [String: String]?) {
        self.url = url
        self.data = data
        self.statusCode = statusCode
        self.headers = headers
    }
}
