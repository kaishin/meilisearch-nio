import Foundation

typealias RequestMiddleware = (Request) throws -> (Request)

@resultBuilder
struct RequestBuilder {
  static func buildBlock(_ components: RequestMiddleware...) -> RequestMiddleware {
    {
      try components.reduce($0) { transformed, component in
        return try component(transformed)
      }
    }
  }
}

struct Endpoint {
  var request: Request

  init(
    path: URLPath,
    @RequestBuilder builder: @escaping () -> RequestMiddleware
  ) throws {
    self.request = try builder()(Request(path: path))
  }
}

extension Endpoint {
  static func getAllDocuments(
    indexUid: String,
    getParameters: GetParameters = .init()
  ) throws -> Self {
    try .init(
      path: .indexes / indexUid / .documents
    ) {
      requestQueries(getParameters.toQueryParameters())
    }
  }
}
