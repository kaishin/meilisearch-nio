import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

public struct MeiliSearchClient {
  public var host: () -> String
  public var adminAPIKey: () -> String?
  public var network: () -> NetworkClient
  public var defaultDecoder: () -> JSONDecoder

  public init(
    host: @escaping @autoclosure () -> String,
    adminAPIKey: @escaping @autoclosure () -> String?,
    network: @escaping @autoclosure () -> NetworkClient,
    defaultDecoder: @escaping @autoclosure () -> JSONDecoder
  ) {
    self.host = host
    self.adminAPIKey = adminAPIKey
    self.network = network
    self.defaultDecoder = defaultDecoder
  }

  var hostURL: URL? {
    URL(string: host())
  }
}

extension MeiliSearchClient {
  func httpRequest(from request: Request) throws -> HTTPClient.Request {
    // Headers
    var headers = HTTPHeaders()

    for header in request.headers {
      headers.add(name: header.key, value: header.value)
    }

    if headers.contains(name: .authorization) == false,
       let adminKey = adminAPIKey() {
      headers.add(name: .authorization, value: "Bearer \(adminKey)")
    }

    return try HTTPClient.Request(
      url: try requestURL(for: request),
      method: request.method,
      headers: headers,
      body: request.body.map { .byteBuffer($0) }
    )
  }

  private func requestURL(for request: Request) throws -> URL {
    guard var requestURL = hostURL else {
      throw MeiliSearchError.invalidHost
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
      throw MeiliSearchError.malformedRequestURL
    }

    components.queryItems = request.queryItems

    guard let urlWithQueries = components.url else {
      throw MeiliSearchError.malformedRequestURL
    }

    return urlWithQueries
  }
}

extension MeiliSearchClient {
  func send(
    _ path: URLPath,
    _ middleware: @escaping RequestMiddleware = identity,
    on eventLoop: EventLoop? = nil
  ) async throws -> HTTPClient.Response {
    let httpRequest = try httpRequest(from: middleware(.init(path: path)))
    return try await network().send(httpRequest, eventLoop)
  }

  func send<T>(
    _ path: URLPath,
    _ middleware: @escaping RequestMiddleware = identity,
    decoder: JSONDecoder? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> T where T: Decodable {
    let response: HTTPClient.Response = try await send(path, middleware, on: eventLoop)
    let requestDecoder = decoder ?? Self.defaultJSONDecoder

    guard let responseData = response.body else {
      throw MeiliSearchError.missingResponseData
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

    guard let responseData = response.body else {
      throw MeiliSearchError.missingResponseData
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

public extension MeiliSearchClient {
  static let defaultJSONDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
    return decoder
  }()

  static let defaultJSONEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(Formatter.iso8601)
    return encoder
  }()

  static func live(
    httpClient: HTTPClient,
    decoder: JSONDecoder = Self.defaultJSONDecoder
  ) throws -> Self {
    guard let url = Environment[ConfigKeys.url]
    else {
      throw MeiliSearchError.missingConfiguration(ConfigKeys.url.rawValue)
    }

    guard let adminAPIKey = Environment[ConfigKeys.apiKey]
    else {
      throw MeiliSearchError.missingConfiguration(ConfigKeys.apiKey.rawValue)
    }

    return .init(
      host: url,
      adminAPIKey: adminAPIKey,
      network: .live(with: httpClient),
      defaultDecoder: decoder
    )
  }

  static let mock: Self = {
    .init(
      host: "localhost",
      adminAPIKey: "",
      network: .mock,
      defaultDecoder: Self.defaultJSONDecoder
    )
  }()
}
