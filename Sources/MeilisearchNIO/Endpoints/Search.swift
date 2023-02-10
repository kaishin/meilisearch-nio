import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeiliSearchClient {
  /// Search for documents matching a specific query in the given index.
  /// - Parameters:
  ///   - indexID: The index UID to search in.
  ///   - params: Search parameters.
  ///   - decoder: An optional object decoder.
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: A search result of the concrete type.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/search.html#search-in-an-index-with-post-route)
  public func search<T>(
    in indexUID: String,
    with params: SearchParameters,
    decoder: JSONDecoder? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> SearchResult<T> where T: Codable, T: Equatable {
    try await send(
      .indexes / indexUID / .search,
      post(body: params),
      on: eventLoop
    )
  }
}
