import Foundation

@testable import Harvey

final class HarveyTestsDataSource: HarveyDataSourceProtocol {

    let shouldStub: (URLRequest) -> Bool
    let stubbedResponse: (URLRequest) -> HarveyResponse?

    init(shouldStub: @escaping (URLRequest) -> Bool, stubbedResponse: @escaping (URLRequest) -> HarveyResponse?) {
        self.shouldStub = shouldStub
        self.stubbedResponse = stubbedResponse
    }

    func shouldStub(request: URLRequest) -> Bool {
        return shouldStub(request)
    }

    func stubbedResponse(for request: URLRequest) -> HarveyResponse? {
        return stubbedResponse(request)
    }
}
