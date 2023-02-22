import Foundation
import NIOHTTP1
import NIO

// MARK: - Property Transforms
var identity: RequestMiddleware = { $0 }

func requestHeader(
  key: String,
  value: String
) -> RequestMiddleware {
  { request in
    var copy = request
    copy.headers[key] = value
    return copy
  }
}

func requestMethod(
  _ method: HTTPMethod
) -> RequestMiddleware {
  { request in
    var copy = request
    copy.method = method
    return copy
  }
}

func requestBody(
  _ data: Data
) -> RequestMiddleware {
  { request in
    var copy = request
    copy.body = ByteBuffer(bytes: data)
    return copy
  }
}

func requestBody<T>(
  _ content: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  { request in
    guard request.method != .GET else { return request }
    var copy = request
    copy.body = ByteBuffer(
      bytes: try encoder.encode(content)
    )
    return copy
  }
}

func requestQueries(
  _ content: [String: String]
) -> RequestMiddleware {
  { request in
    var copy = request
    copy.queryItems = content.reduce([], { items, keyValue in
      let item = URLQueryItem(name: keyValue.0, value: keyValue.1)
      var newItems = items
      newItems.append(item)
      return newItems
    })
    return copy
  }
}

// MARK: - Common Transforms
let getRequest: RequestMiddleware = requestMethod(.GET)
let jsonContentRequest: RequestMiddleware = requestHeader(
  key: "Content-Type",
  value: "application/json; charset=utf-8"
)

let acceptRequest: RequestMiddleware = requestHeader(
  key: "Accept",
  value: "application/json; charset=utf-8"
)

func bearerAuth(_ token: String) -> RequestMiddleware {
  requestHeader(key: .authorization, value: "Bearer \(token)")
}

func requestMiddleware(
  @RequestBuilder build: () -> RequestMiddleware
) -> RequestMiddleware {
  build()
}

var jsonRequest = requestMiddleware {
  jsonContentRequest
  acceptRequest
}

let postRequest = requestMiddleware {
  requestMethod(.POST)
  jsonRequest
}

let putRequest = requestMiddleware {
  requestMethod(.PUT)
  jsonRequest
}

let patchRequest = requestMiddleware {
  requestMethod(.PATCH)
  jsonRequest
}

let deleteRequest = requestMiddleware {
  requestMethod(.DELETE)
  jsonRequest
}

func post<T>(
  body: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  requestMiddleware {
    postRequest
    requestBody(body)
  }
}

func post(
  data: Data
) -> RequestMiddleware {
  requestMiddleware {
    postRequest
    requestBody(data)
  }
}

func put<T>(
  body: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  requestMiddleware {
    putRequest
    requestBody(body)
  }
}

func put(
  data: Data
) -> RequestMiddleware {
  requestMiddleware {
    putRequest
    requestBody(data)
  }
}

func patch<T>(
  body: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  requestMiddleware {
    patchRequest
    requestBody(body)
  }
}

func patch(
  data: Data
) -> RequestMiddleware {
  requestMiddleware {
    patchRequest
    requestBody(data)
  }
}

func delete<T>(
  body: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  requestMiddleware {
    deleteRequest
    requestBody(body)
  }
}

func delete(
  data: Data
) -> RequestMiddleware {
  requestMiddleware {
    deleteRequest
    requestBody(data)
  }
}
