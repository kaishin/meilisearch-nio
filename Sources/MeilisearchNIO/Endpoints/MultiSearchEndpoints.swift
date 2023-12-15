import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// Bundle multiple search queries in a single API request. Use this endpoint to search through multiple indexes at once.
  /// - Parameters:
  ///   - params: Multi search parameters.
  ///   - decoder: An optional object decoder.
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: A search result of the concrete type.
  ///
  /// - SeeAlso: [Official documentation](https://www.meilisearch.com/docs/reference/api/multi_search)
  public func multiSearch<T>(
    with params: MultiSearchParameters,
    decoder: JSONDecoder? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> MultiSearchResponse<T> where T: Codable, T: Equatable {
    try await send(
      .multiSearch,
      on: eventLoop
    ) {
      post(body: params)
    }
  }
}
