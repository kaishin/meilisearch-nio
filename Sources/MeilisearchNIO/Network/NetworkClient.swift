import Foundation
import AsyncHTTPClient
import NIO
import NIOFoundationCompat

public struct NetworkClient {
  public typealias RequestResponse = (
    _ request: HTTPClient.Request,
    _ on: EventLoop?
  ) async throws -> HTTPClient.Response

  public var send: RequestResponse

  public init(
    send: @escaping RequestResponse
  ) {
    self.send = send
  }
}

public extension NetworkClient {
  static func live(with client: HTTPClient) -> Self {
    .init(
      send: { request, eventLoop in
        let eventLoopPreference: HTTPClient.EventLoopPreference = {
          if let eventLoop = eventLoop {
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
