import Foundation
import NIOHTTP1
import NIO

typealias RequestMiddleware = (Request) throws -> (Request)

// MARK: - Property Transforms
var identity: RequestMiddleware = { $0 }

func requestHeader(
  key: String,
  value: String
) -> RequestMiddleware {
  { request in
    var newRequest = request
    newRequest.headers[key] = value
    return newRequest
  }
}

func requestMethod(
  _ method: HTTPMethod
) -> RequestMiddleware {
  { request in
    var newRequest = request
    newRequest.method = method
    return newRequest
  }
}

func requestBody(
  _ data: Data
) -> RequestMiddleware {
  { request in
    var newRequest = request
    newRequest.body = ByteBuffer(bytes: data)
    return newRequest
  }
}

func requestBody<T>(
  _ content: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  { request in
    guard request.method != .GET else { return request }
    var newRequest = request
    newRequest.body = ByteBuffer(
      bytes: try encoder.encode(content)
    )
    return newRequest
  }
}

func requestQueries(
  _ content: [String: String]
) -> RequestMiddleware {
  { request in
    var newRequest = request
    newRequest.queryItems = content.reduce([], { items, keyValue in
      let item = URLQueryItem(name: keyValue.0, value: keyValue.1)
      var newItems = items
      newItems.append(item)
      return newItems
    })
    return newRequest
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

let jsonRequest = pipe(jsonContentRequest, acceptRequest)

let postRequest: RequestMiddleware = pipe(
  requestMethod(.POST),
  jsonRequest
)

let putRequest: RequestMiddleware = pipe(
  requestMethod(.PUT),
  jsonRequest
)

let patchRequest: RequestMiddleware = pipe(
  requestMethod(.PATCH),
  jsonRequest
)

let deleteRequest: RequestMiddleware = pipe(
  requestMethod(.DELETE),
  jsonRequest
)

func post<T>(
  body: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  pipe(
    postRequest,
    requestBody(body)
  )
}

func post(
  data: Data
) -> RequestMiddleware {
  pipe(
    postRequest,
    requestBody(data)
  )
}

func put<T>(
  body: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  pipe(
    putRequest,
    requestBody(body)
  )
}

func put(
  data: Data
) -> RequestMiddleware {
  pipe(
    putRequest,
    requestBody(data)
  )
}

func patch<T>(
  body: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  pipe(
    patchRequest,
    requestBody(body)
  )
}

func patch(
  data: Data
) -> RequestMiddleware {
  pipe(
    patchRequest,
    requestBody(data)
  )
}

func delete<T>(
  body: T,
  encoder: JSONEncoder = .init()
) -> RequestMiddleware where T: Encodable {
  pipe(
    deleteRequest,
    requestBody(body)
  )
}

func delete(
  data: Data
) -> RequestMiddleware {
  pipe(
    deleteRequest,
    requestBody(data)
  )
}
