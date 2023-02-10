import AsyncHTTPClient
import Foundation
import NIO
import NIOFoundationCompat

struct NetworkClient {
  typealias RequestResponse = (
    _ request: HTTPClient.Request,
    _ on: EventLoop?
  ) async throws -> HTTPClient.Response

  var send: RequestResponse

  init(
    send: @escaping RequestResponse
  ) {
    self.send = send
  }
}

extension NetworkClient {
  static func live(with client: HTTPClient) -> Self {
    .init(
      send: { request, eventLoop in
        let eventLoopPreference: HTTPClient.EventLoopPreference = {
          if let eventLoop {
            return .delegate(on: eventLoop)
          } else {
            return .indifferent
          }
        }()

        return try await client.execute(
          request: request,
          eventLoop: eventLoopPreference
        ).get()
      }
    )
  }

  static let mock: Self = {
    .init(
      send: { _, _ in
        return .init(
          host: "",
          status: .accepted,
          version: .http1_0,
          headers: .init(),
          body: nil
        )
      }
    )
  }()
}
