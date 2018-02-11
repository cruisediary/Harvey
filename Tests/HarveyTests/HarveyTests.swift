import Foundation
import Quick
import Nimble

@testable import Harvey

final class HarveyStubConfiguration: QuickConfiguration {
    override static func configure(_ configuration: Configuration) {
        sharedExamples("successfully stubbed response") { (context: SharedExampleContext) in
            let urlSession = context()["url_session"] as! URLSession
            let stubbedResponse = context()["stubbed_response"] as! HarveyResponse
            var dataSource: HarveyDataSourceProtocol!

            beforeEach {
                dataSource = HarveyTestsDataSource(shouldStubClosure: { request -> Bool in
                    switch request.url?.absoluteString {
                    case stubbedResponse.url.absoluteString?: return true
                    default: return false
                    }
                }, stubbedResponseClosure: { request -> HarveyResponse? in
                    switch request.url?.absoluteString {
                    case stubbedResponse.url.absoluteString?: return stubbedResponse
                    default: return nil
                    }
                })
                Harvey.add(dataSource: dataSource)
            }

            afterEach {
                Harvey.remove(dataSource: dataSource)
            }

            it("should stub given response") {
                var response: HTTPURLResponse?
                var receivedData: Data?
                let downloadTask = urlSession.dataTask(with: stubbedResponse.url) { (data, receivedResponse, _) in
                    response = receivedResponse as? HTTPURLResponse
                    receivedData = data
                }
                downloadTask.resume()

                expect(receivedData).toEventually(equal(stubbedResponse.data))
                expect(response?.statusCode).toEventually(equal(stubbedResponse.statusCode))
                expect(response?.allHeaderFields).toEventually(equal(stubbedResponse.httpUrlResponse.allHeaderFields))
                expect(response?.url?.absoluteString).toEventually(equal(stubbedResponse.url.absoluteString))
            }

            it("shouldn't stub other responses") {
                let nonStubbedResponse = HarveyResponse(url: URL(string: "https://google.com")!, data: "test data".data(using: .utf8)!, statusCode: 204, headers: nil)
                var response: HTTPURLResponse?
                var receivedData: Data?
                let downloadTask = urlSession.dataTask(with: nonStubbedResponse.url) { (data, receivedResponse, _) in
                    response = receivedResponse as? HTTPURLResponse
                    receivedData = data
                }
                downloadTask.resume()

                expect(receivedData).toEventuallyNot(equal(stubbedResponse.data))
                expect(response?.statusCode).toEventuallyNot(equal(stubbedResponse.statusCode))
                expect(response?.allHeaderFields).toEventuallyNot(equal(stubbedResponse.httpUrlResponse.allHeaderFields))
                expect(response?.url?.absoluteString).toEventuallyNot(equal(stubbedResponse.url.absoluteString))
            }

            it("shouldn't stub other responses after removing the dataSource") {
                Harvey.remove(dataSource: dataSource)

                var response: HTTPURLResponse?
                var receivedData: Data?
                let downloadTask = urlSession.dataTask(with: stubbedResponse.url) { (data, receivedResponse, _) in
                    response = receivedResponse as? HTTPURLResponse
                    receivedData = data
                }
                downloadTask.resume()

                expect(receivedData).toEventuallyNot(equal(stubbedResponse.data))
                expect(response?.statusCode).toEventuallyNot(equal(stubbedResponse.statusCode))
                expect(response?.allHeaderFields).toEventuallyNot(equal(stubbedResponse.httpUrlResponse.allHeaderFields))
            }
        }
    }
}

final class HarveyTests: QuickSpec {

    override func spec() {
        Harvey.startStubbing()

        describe("given one httpbin endpoint") {
            let url = URL(string: "https://httpbin.org/uuid")!

            context("when URLSession.shared") {
                itBehavesLike("successfully stubbed response") {
                    let data = "{\"uuid\": \"b3c91aa8-1f3b-40e4-8392-725280d2ccbd\"}".data(using: String.Encoding.utf8)!
                    let headers = ["Harvey": "Moya"]
                    let stubbedResponse = HarveyResponse(url: url, data: data, statusCode: 201, headers: headers)
                    return ["url_session": URLSession.shared, "stubbed_response": stubbedResponse]
                }
            }

            context("when URLSession with default config") {
                itBehavesLike("successfully stubbed response") {
                    let data = "{\"uuid\": \"9b5b5a5f-a601-4599-afc9-f8676d9621ad\"}".data(using: String.Encoding.utf8)!
                    let headers = ["Moya": "Aeryn"]
                    let stubbedResponse = HarveyResponse(url: url, data: data, statusCode: 202, headers: headers)
                    let session = URLSession(configuration: URLSessionConfiguration.default)
                    return ["url_session": session, "stubbed_response": stubbedResponse]
                }
            }

            context("when URLSession with ephemeral config") {
                itBehavesLike("successfully stubbed response") {
                    let data = "{\"uuid\": \"19c067e5-d907-4197-85a5-2ab3f8fb9c7a\"}".data(using: String.Encoding.utf8)!
                    let headers = ["Aeryn": "Moya"]
                    let stubbedResponse = HarveyResponse(url: url, data: data, statusCode: 203, headers: headers)
                    let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
                    return ["url_session": session, "stubbed_response": stubbedResponse]
                }
            }
        }
    }
}
