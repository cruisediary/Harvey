import Foundation

public protocol HarveyDataSourceProtocol: class {
    func shouldStub(for request: URLRequest) -> Bool
    func stubbedResponse(for request: URLRequest) -> HarveyResponse?
}
