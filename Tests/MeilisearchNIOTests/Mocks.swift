import Foundation
@testable import MeilisearchNIO
import NIOHTTP1

extension NetworkClient {
  static func mock(
    response: String,
    status: HTTPResponseStatus = .ok
  ) -> Self {
    .init { request, eventloop in
      .init(
        host: "",
        status: status, 
        version: .http1_1, 
        headers: [:],
        body: try? .from(response)
      )
    }
  }
}

extension MeilisearchClient {
  static func mock(
    networkClient: NetworkClient
  ) -> Self {
    .init(networkClient: networkClient)
  }
}
