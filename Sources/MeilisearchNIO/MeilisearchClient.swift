import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

public struct MeilisearchClient {
  var host: String
  var adminAPIKey: String?
  var network: NetworkClient
  var defaultDecoder: JSONDecoder

  public init(
    httpClient: HTTPClient,
    decoder: JSONDecoder = Self.defaultJSONDecoder
  ) throws {
    guard 
      let url = Environment[ConfigKeys.url]
    else {
      throw MeilisearchError.missingConfiguration(ConfigKeys.url.rawValue)
    }

    guard 
      let adminAPIKey = Environment[ConfigKeys.apiKey]
    else {
      throw MeilisearchError.missingConfiguration(ConfigKeys.apiKey.rawValue)
    }

    self.host = url
    self.adminAPIKey = adminAPIKey
    self.network = .live(with: httpClient)
    self.defaultDecoder = decoder
  }

  var hostURL: URL? {
    URL(string: host)
  }
}

extension MeilisearchClient {
  func httpRequest(from request: Request) throws -> HTTPClient.Request {
    // Headers
    var headers = HTTPHeaders()

    for header in request.headers {
      headers.add(name: header.key, value: header.value)
    }

    return try .init(
      url: try requestURL(for: request),
      method: request.method,
      headers: headers,
      body: request.body.map { .byteBuffer($0) }
    )
  }

  private func requestURL(for request: Request) throws -> URL {
    guard var requestURL = hostURL else {
      throw MeilisearchError.invalidHost
    }

    request.path.fragments.forEach {
      requestURL.appendPathComponent($0)
    }

    if request.queryItems.isEmpty {
      return requestURL
    }

    // Query Items
    guard var components = URLComponents(
      url: requestURL,
      resolvingAgainstBaseURL: true
    ) else {
      throw MeilisearchError.malformedRequestURL
    }

    components.queryItems = request.queryItems

    guard let urlWithQueries = components.url else {
      throw MeilisearchError.malformedRequestURL
    }

    return urlWithQueries
  }
}

extension MeilisearchClient {
  func send(
    _ path: URLPath,
    _ middleware: @escaping RequestMiddleware = identity,
    on eventLoop: EventLoop? = nil
  ) async throws -> HTTPClient.Response {
    let httpRequest = try httpRequest(from: middleware(.init(path: path)))
    return try await network.send(httpRequest, eventLoop)
  }

  func send<T>(
    _ path: URLPath,
    _ middleware: @escaping RequestMiddleware = identity,
    decoder: JSONDecoder? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> T where T: Decodable {
    let response: HTTPClient.Response = try await send(path, middleware, on: eventLoop)
    let requestDecoder = decoder ?? Self.defaultJSONDecoder

    guard 
      let responseData = response.body
    else {
      throw MeilisearchError.missingResponseData
    }

    if 400...599 ~= response.status.code {
      if let errorResponse = try? requestDecoder.decode(
        ErrorResponse.self,
        from: responseData
      ) {
        throw errorResponse
      }
    }

    return try requestDecoder.decode(T.self, from: responseData)
  }

  func send(
    _ path: URLPath,
    _ middleware: @escaping RequestMiddleware = identity,
    on eventLoop: EventLoop? = nil
  ) async throws {
    let response: HTTPClient.Response = try await send(path, middleware, on: eventLoop)

    guard 
      let responseData = response.body
    else {
      throw MeilisearchError.missingResponseData
    }

    if 400...599 ~= response.status.code {
      if let errorResponse = try? Self.defaultJSONDecoder.decode(
        ErrorResponse.self,
        from: responseData
      ) {
        throw errorResponse
      }
    }
  }
}

extension MeilisearchClient {
  public static let defaultJSONDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
    return decoder
  }()

  public static let defaultJSONEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(Formatter.iso8601)
    return encoder
  }()
}
