import Foundation

@testable import Harvey

final class HarveyTestsDataSource: HarveyDataSourceProtocol {

    let shouldStubClosure: (URLRequest) -> Bool
    let stubbedResponseClosure: (URLRequest) -> HarveyResponse?

    init(shouldStubClosure: @escaping (URLRequest) -> Bool, stubbedResponseClosure: @escaping (URLRequest) -> HarveyResponse?) {
        self.shouldStubClosure = shouldStubClosure
        self.stubbedResponseClosure = stubbedResponseClosure
    }

    func shouldStub(for request: URLRequest) -> Bool {
        return shouldStubClosure(request)
    }

    func stubbedResponse(for request: URLRequest) -> HarveyResponse? {
        return stubbedResponseClosure(request)
    }
}
