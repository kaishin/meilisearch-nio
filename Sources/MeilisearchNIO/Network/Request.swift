import Foundation
import NIOHTTP1
import NIO

struct Request {
  var method: HTTPMethod
  var path: URLPath
  var queryItems: [URLQueryItem]
  var headers: [String: String]
  var body: ByteBuffer?
}

extension Request {
  init(
    method: HTTPMethod = .GET,
    path: URLPath = .init(),
    headers: [String: String] = [:],
    queryItems: [URLQueryItem] = [],
    body: ByteBuffer? = nil
  ) {
    self.method = method
    self.path = path
    self.headers = headers
    self.queryItems = queryItems
    self.body = body
  }
}
